describe TubeStatus do

	let(:tube) { TubeStatus.new }
	let(:status_good) { double :status , status_description: "Good Service" }
	let(:status_bad) { double :status , status_description: "Minor Delays" }
	let(:line1) {double :line, name: "Bakerloo", status: status_good }
	let(:line2) {double :line, name: "Central", status: status_good}
	let(:line3) {double :line, name: "City Line", status: status_bad}
	let(:lines) { [line1,line2,line3] }
	let(:service_disruption) { double :ServiceDisruption, lines: lines }

	before do 
		stub_request(:get, "http://cloud.tfl.gov.uk/TrackerNet/LineStatus")
		allow(tube).to receive(:status).and_return(service_disruption)
	end

	it "is initialized with a tube status" do 
		expect(tube.status).to eq service_disruption
	end

	it "gets the status of all lines" do 
		expect(tube.get_status_of_delayed_tubes).to eq [{:line_name=>"City Line", :status=>"Minor Delays"}]
	end

	it "can create a JSON hash for the printer" do 
		expect(tube.json).to eq [{:format=>"TEXT", :text=>"City Line: Minor Delays"}]
	end


end 
