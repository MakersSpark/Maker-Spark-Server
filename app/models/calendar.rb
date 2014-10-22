class Calendar

  attr_accessor :uri, :todays_events
  attr_reader :data

  MAKERS_CALENDAR_URI = 'https://www.google.com/calendar/ical/makersacademy.com_jf3r3c3vu43mslp07ddsh7e570%40group.calendar.google.com/public/basic.ics'

  def initialize(uri = MAKERS_CALENDAR_URI)
    @uri = uri
    @data = Icalendar.parse(open(@uri)).first
    @todays_events = []
    get_events
  end

  def get_events
    get_todays_non_recurring_events
    reject_non_recurring_events
    #### these seem to be breaking things - commenting them out for now
    # get_daily_events
    # get_weekly_events
    # get_monthly_events
    ####
  end

  def get_todays_non_recurring_events

    @todays_events += data.events.select{ |event| event.rrule == [] && event.dtstart.to_date == Time.now.to_date } # gets events that do not repeat and are today

  end

  def reject_non_recurring_events
    @sanitised_events = data.events
    @sanitised_events.reject! { |event| event.rrule == [] }
    @sanitised_events.reject! { |event| event.rrule.first.count != nil }
    @sanitised_events.reject! { |event| event.rrule.first.until != nil && event.rrule.first.until < DateTime.now }
    @todays_events += @sanitised_events
  end

  #### these seem to be breaking things - commenting them out for now
  # def get_daily_events
  #   @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "DAILY"  }
  # end
  # def get_weekly_events
  #   @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "WEEKLY" && event.dtstart.strftime('%A') == DateTime.now.strftime('%A') }
  # end

  # def get_monthly_events
  #   @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "MONTHLY" && event.dtstart.strftime('%d') == DateTime.now.strftime('%d') }
  # end
  ####

  def get_todays_events_formatted
    if @todays_events.any?
      events = @todays_events.map { |e| ["TEXT","#{e.dtstart.strftime("%H:%M")} #{e.summary}"] }.sort
    else
      events = ["TEXT","No Makers events today."]
    end
    events
  end

  def json
    if @todays_events.any?
      events = @todays_events.map { |e| {format: "TEXT", text: "#{e.dtstart.strftime("%H:%M")} #{e.summary}"}  }.sort { |a,b| a[:text] <=> b[:text] }
    else
      events = [{format: "TEXT", text: "No Makers events today."}]
    end
    events
  end


end