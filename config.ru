require "./app/server"
Dir.glob('./app/{models,helpers,controllers}/*.rb').each { |file| require file }

map('/') { run SparkPrint }
map('/users') { run UsersController }
map('/printer') { run PrinterController }
map('/messages') { run MessagesController }
map('/angular') { run AngularController }