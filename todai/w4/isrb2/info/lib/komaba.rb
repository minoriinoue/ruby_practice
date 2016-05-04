require "komaba/app"
require "komaba/model"
require "komaba/view"

# this file is deprecated

model = Komaba::Model.new(Komaba::View)
app = Komaba::App.new(model)
END {
  app.dispose
}
