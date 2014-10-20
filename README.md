# Spark Printer

A tiny, wireless, RFID-enabled, open source personal printing platform.

Start by tapping your RFID card on the reader – Spark Printer will print out a link for you to follow. There, you can register and customise your printouts. Once set up, tap your card on the reader to receive a personalised, context-aware printout.

The server handles user signup and login, and parses and formats messages for printing before sending them to the printer using the [Spark Cloud API](http://docs.spark.io/api/).

## The family

Spark Printer has several distinct components which work together. The repos are linked below.

* **[Spark Printer Server](https://github.com/MakersSpark/Maker-Spark-Server)** – you're looking at it. A Sinatra webserver which controls the printer, handles user registration and login, allows users to customise their printouts and pulls in data from various APIs to print for users.
* **[Spark Printer Firmware](https://github.com/MakersSpark/spark-printer-firmware)** – C++ code and libraries for Spark Core. When hooked up to the right hardware, this handles reading RFID cards, sending them to the server, receiving print requests and controlling the printer.
* **[Spark Printer Push Server](https://github.com/MakersSpark/spark-rfid-push)** – a simple node.js app that listens for messages from the Spark Core (specifically, announcements of the ID of RFID cards it reads) and forwards them on to the Spark Printer Server for processing.

## Technologies

**Back-end**
* Ruby
* Sinatra
* C++ and [Spark Cloud](http://spark.io)
* node.js
* Postgres
* DataMapper

**Front-end**
* AngularJS
* jQuery
* Bootstrap

**Hardware**
* [Spark Core](http://spark.io)

**Hosting**
* Dokku
* Heroku & DigitalOcean

**Testing**
* RSpec
* Capybara
* WebMock
 
**APIs**
* [Transport for London](https://www.tfl.gov.uk/info-for/open-data-users/)
* [Twitter](https://www.tfl.gov.uk/info-for/open-data-users/)
* [The Guardian](http://www.theguardian.com/open-platform)
* [GitHub](https://developer.github.com/)
* [forecast.io](http://forecast.io)
