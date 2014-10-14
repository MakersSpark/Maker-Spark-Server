# Spark Printer Server

Server app for **Spark Printer**, a tiny, wireless, RFID-enabled personal printing platform.

The server handles user signup and login, and parses and formats messages for printing before sending them to the printer using the [Spark Cloud API](http://docs.spark.io/api/).

## Technologies

* Ruby
* Sinatra
* [EventMachine](https://github.com/eventmachine/eventmachine) for processing inbound server-side events from Spark Printer
* RSpec and Capybara for testing