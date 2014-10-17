class Calendar

  attr_accessor :uri, :todays_events
  attr_reader :data

  def initialize(uri)
    @uri = uri
    @data = Icalendar.parse(open(@uri)).first
    @todays_events = []
  end

  def get_events
    get_todays_non_recurring_events
    reject_non_recurring_events
    get_daily_events
    get_weekly_events
    get_monthly_events
    nil
  end

  def get_todays_non_recurring_events
    @todays_events += data.events.select{ |event| event.rrule == [] && event.dtstart.today? } # gets events that do not repeat and are today
  end

  def reject_non_recurring_events
    @sanitised_events = data.events.reject{ |event| event.rrule == [] }
  end

  def get_daily_events
    @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "DAILY"  }
  end
  def get_weekly_events
    @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "WEEKLY" && event.dtstart.strftime('%A') == DateTime.now.strftime('%A') }
  end

  def get_monthly_events
    @todays_events += @sanitised_events.select{ |event| event.rrule.first.frequency == "MONTHLY" && event.dtstart.strftime('%d') == DateTime.now.strftime('%d') }
  end

  def get_todays_events_formatted
    get_events
    result = []
    @todays_events.each do |e|
      if Time.now.zone == "BST"
        eventtime = e.dtstart + 3600
        result << ["TEXT","#{e.dtstart.strftime("%H:%M")} #{e.summary}"]
      else
        eventtime = e.dtstart
        result << ["TEXT","#{e.dtstart.strftime("%H:%M")} #{e.summary}"]
      end
    end

    result.sort
  end


end