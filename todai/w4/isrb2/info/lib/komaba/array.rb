require "komaba/app"
require "komaba/model"

model = Komaba::Model.new
app = Komaba::App.new(model)

END {
  app.dispose
}
