require "rbconfig"
require "fileutils"

option = {:noop => false, :verbose => true}

bindir     = Config::CONFIG["bindir"]
sitelibdir = Config::CONFIG["sitelibdir"]

FileUtils.mkdir_p(bindir)
FileUtils.mkdir_p(sitelibdir)

Dir.glob("bin/*") do |path|
  path =~ /(?:\/)(.+)$/
  dst = File.dirname(File.join(bindir, $1))
  FileUtils.mkdir_p(dst)
  FileUtils.install(path, dst, option)
end

Dir.glob("lib/**/*.rb\0lib/**/*.png") do |path|
  path =~ /(?:\/)(.+)$/
  dst = File.dirname(File.join(sitelibdir, $1))
  FileUtils.mkdir_p(dst)
  FileUtils.install(path, dst, option)
end

puts "Installation Komaba completed!"
