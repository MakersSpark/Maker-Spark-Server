class Calendar

  attr_accessor :uri, :todays_events
  attr_reader :data

  def initialize(uri)
    @uri = uri
    @data = Icalendar.parse(open(@uri)).first
    @todays_events = []
  end

  def get_events
    puts "-------------------"
    # data.events.each {|e| puts e.rrule.frequency }
    data.events.each {|e| puts e.rrule.first.frequency }
    puts "-------------------"

    @todays_events += data.events.select{ |event| event.rrule == [] && event.dtstart.today? } # gets events that do not repeat and are today
    @todays_events += data.events.select{ |event| event.rrule.first.frequency == "DAILY"  }
    @todays_events += data.events.select{ |event| event.rrule.first.frequency == "WEEKLY" &&  event.dtstart.strftime('%A') == DateTime.now.strftime('%A') }
    @todays_events += data.events.select{ |event| event.rrule.first.frequency == "MONTHLY" && event.dtstart.strftime('%d') == DateTime.now.strftime('%d') }
  end


end