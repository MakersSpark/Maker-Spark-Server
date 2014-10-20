describe Calendar do 

  let(:valid_uri) { "https://www.google.com/calendar/ical/henrystanley.com_uh7l5drs1sfnju9eivnml389k8%40group.calendar.google.com/private-95d6172bf50f4f3783be77c8a0dfce42/basic.ics"}
  let(:invalid_uri) { "https://www.google.com/calendar/ical/henrystanley.com_uh7l5drs1sfnju9eivnml389k8%40group.calendar.google.com/private-95d6172bf50f4f3783be77c8a0dfce42/basic.xml"}
  # let(:ical) { Icalendar.new('byverdu') }
  let(:calendar_file) { File.open("spec/assets/calendar.ics") }
  let(:calendar_file_two) { File.open("spec/assets/calendar.ics") }
  let(:alberts_calendar) { Calendar.new(valid_uri) }

  before do
    stub_request(:get, valid_uri).to_return(:body => calendar_file)
    stub_request(:get, invalid_uri)
    stub_request(:get, Calendar::MAKERS_CALENDAR_URI).to_return(:body => calendar_file_two)
    now = Time.local(2014,10,17)
    Timecop.freeze(now)
  end

   it "is can be initialized with a valid url" do 
     expect(alberts_calendar.uri).to eq valid_uri
   end

   it "by default, uses the hard-coded Makers Academy calendar" do
    calendar = Calendar.new
    expect(calendar.uri).to eq(Calendar::MAKERS_CALENDAR_URI)
   end

   ### This validation should be done at the database and feature level!
   # it "cannot be initialized with an invalid (non-.ics) url" do
   #    expect{ Calendar.new(invalid_uri)}.to raise_error
   # end
   ###

  it 'can get a calendar from a URL as an Icalendar object' do
    expect(alberts_calendar.data).to be_instance_of(Icalendar::Calendar)
  end

  it "can select all daily events" do
    daily_events = ["Demo: life at 1000WPM with Ethel","Spark Printer team meeting","Learning FORTRAN with Enrique"]
    alberts_calendar.get_events
    daily_events.each do |event|
        expect(alberts_calendar.todays_events.map {|event| event.summary}).to include event
    end
  end

  it "select events that are weekly and on the same day" do 
    alberts_calendar.get_events
    expect(alberts_calendar.todays_events.map {|event| event.summary}).to include("Weekly event")
  end

  it "does not select events that are weekly and not on the same day" do 
    alberts_calendar.get_events
    expect(alberts_calendar.todays_events.map {|event| event.summary}).not_to include("Other weekly event")
  end

  it "select events that are monthly and on the same day" do 
    alberts_calendar.get_events
    expect(alberts_calendar.todays_events.map {|event| event.summary}).to include("Monthly event")
  end

  it "can return a list of today's events" do
    expect(alberts_calendar.get_todays_events_formatted).to eq(
        [["TEXT", "09:00 Weekly event"],
        ["TEXT", "10:00 Learning FORTRAN with Enrique"],
        ["TEXT", "11:30 Spark Printer team meeting"],
        ["TEXT", "14:30 Monthly event"],
        ["TEXT", "15:30 Non-recurring event"],
        ["TEXT", "17:15 Demo: life at 1000WPM with Ethel"]]
      )
  end 

  it "can return a json of today's events" do 
    expect(alberts_calendar.calendar_json).to eq (
        [ 
          { format: "TEXT", text: "09:00 Weekly event"},
          { format: "TEXT", text: "10:00 Learning FORTRAN with Enrique"},
          { format: "TEXT", text: "11:30 Spark Printer team meeting"},
          { format: "TEXT", text: "14:30 Monthly event"},
          { format: "TEXT", text: "15:30 Non-recurring event"},
          { format: "TEXT", text: "17:15 Demo: life at 1000WPM with Ethel"}
        ]
      ) 
    end   


end 