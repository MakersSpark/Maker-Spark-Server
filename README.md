# Spark Printer Server

Server app for **Spark Printer**, a tiny, wireless, RFID-enabled personal printing platform.

The server handles user signup and login, and parses and formats messages for printing before sending them to the printer using the [Spark Cloud API](http://docs.spark.io/api/).

## Technologies

* Ruby
* Sinatra
* Postgres
* DataMapper
* node.js server for pushing RFID scans to the main Sinatra server for handling
* RSpec and Capybara for testing