module ::Kernel
  def windows?
    Config::CONFIG["arch"] =~ /mswin|mingw/
  end
end

require "rbconfig"
require windows? ? "win32/open3" : "open3"
require "thread"
require "socket"

module Komaba
  class ViewProxy

    def initialize(view_class, serializer)
      @serializer = serializer
      @disposed = false
      @mutex = Mutex.new
      if Config::CONFIG["target"] =~ /apple/
        exe = "rsdl"
      else
        exe = "ruby"
      end
      path_options = ($LOAD_PATH - `ruby -e "puts $:"`.split("\n")).map{|path| "-I#{path}"}.join(" ")
      if windows?
        args = ["#{exe} -rubygems #{path_options} #{__FILE__}", "b"]
      else
        # TODO: do something with -I options
        args = ["#{exe} #{path_options} -I $bindir -I $libdir #{__FILE__}"]
      end
      @pin, @pout, @perr = *Open3.popen3(*args)
      view_proxy = self
      port = @pout.gets.to_i
      @socket = TCPSocket.open("127.0.0.1", port)
      @socket.puts(view_class.name)
      @socket.puts(serializer.name)
      @socket.flush
      if !windows?
        @pout_thread = Thread.new do
          begin
            while line = @pout.gets
              $stdout.puts(line)
              $stdout.flush
            end
          rescue Interrupt, EOFError
          ensure
            @disposed = true
          end
        end
        @perr_thread = Thread.new do
          begin
            while line = @perr.gets
              if line !~ /NSQuickDrawView/
                $stderr.puts(line)
                $stderr.flush
              end
            end
          rescue Interrupt, EOFError
          ensure
            @disposed = true
          end
        end
      end
      @socket.puts("start")
      @socket.flush
    end

    def update(obj)
      raise "can't operate disposed view" if disposed?
      begin
        data = @serializer.serialize(obj)
        raise "invalid object" if data == nil
        size = data.size
        raise "too large data" if (1 << 32) <= size
      rescue
        abort
        raise
      end
      begin
        @mutex.synchronize do
          @socket.puts("update")
          @socket.write([size].pack("I"))
          @socket.write(data)
          @socket.flush
        end
      rescue IOError, Errno::EPIPE, Errno::ECONNRESET, Errno::ECONNABORTED
        abort
      end
    end

    def render_text(text, x, y)
      data = Marshal.dump([text, x, y])
      @mutex.synchronize do
        @socket.puts("render_text")
        @socket.write([data.size].pack("I"))
        @socket.write(data)
        @socket.flush
      end
    end

    def checkpoint
      @mutex.synchronize do
        @socket.puts("checkpoint")
        @socket.flush
      end
    end

    def dispose
      @disposed = true
      @pin.close if @pin and !@pin.closed?
      @pout.close if @pout and !@pout.closed?
      @perr.close if @perr and !@perr.closed?
      @socket.close if @socket and !@socket.closed?
    end

    def disposed?
      @disposed
    end

    def abort
      @mutex.synchronize do
        begin
          @socket.puts("abort")
        rescue Errno::EPIPE, Errno::ECONNRESET, Errno::ECONNABORTED
        end
      end
      dispose
    end

  end
end

if $0 == __FILE__
  begin
    server = TCPServer.new("127.0.0.1", 0)
    $stdout.puts(server.addr[1])
    $stdout.flush
    @socket = server.accept
    view_class_name = @socket.gets.strip
    # ex) AbcDefGHIjkl => abc_def_gh_ijkl
    regexp = /([A-Z]+(?![a-z]))|([A-Z][a-z]*)/
    file = view_class_name.split("::").map do |c|
      c.split(regexp).select{|s| !s.empty?}.join("_").downcase
    end.join("/")
    require(file)

    serializer_module_name = @socket.gets.strip
    file = serializer_module_name.split("::").map do |c|
      c.split(regexp).select{|s| !s.empty?}.join("_").downcase
    end.join("/")
    require(file)

    @socket.gets # "start"

    view = eval(view_class_name).new
    serializer = eval(serializer_module_name)

    begin
      loop do
        if pipes = select([@socket], [], [], 0) and pin = pipes[0][0] and line = pin.gets
          case line.strip
          when "update"
            size = pin.read(4).unpack("I").first
            data = pin.read(size)
            obj = serializer.deserialize(data)
            view.add_object(obj)
          when "render_text"
            size = pin.read(4).unpack("I").first
            data = pin.read(size)
            text, x, y = *Marshal.load(data)
            view.add_text(text, x, y)
          when "checkpoint"
            view.checkpoint
          when "abort"
            exit
          else
            # Don't show the message because it may include bells
            raise "invalid message"
          end
        end
        view.check_disposing
        break if view.disposed?
        view.update
        view.wait
      end
    rescue Interrupt, EOFError, IOError
    end
  rescue SystemExit
  rescue Exception
    if File.writable?(".") and File.executable?(".") and (!File.exist?("./errorlog") or File.writable?("./errorlog"))
      File.open("./errorlog", "a") do |fp|
        fp.puts(Time.now)
        fp.puts($!.class)
        fp.puts($!)
        fp.puts($@)
      end
    end
    $stderr.puts($!.class)
    $stderr.puts($!)
    $stderr.puts($@)
    $stderr.flush
  ensure
    @socket.close if @socket
    view.dispose if view
    $stdout.close
    $stderr.close
  end
end
