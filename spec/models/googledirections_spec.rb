require 'spec_helper'

describe GoogleDirections do

	let(:gmaps) { MyGoogleDirections.new('old street, london') }
	let(:direction) { double :googledirection }

	before do 
		stub_request(:get, "http://maps.googleapis.com/maps/api/directions/xml?alternative=true&destination=old%2Bstreet%252C%2Blondon&language=en&mode=driving&origin=16%2BEpworth%2BStreet%252C%2BIslington%252C%2BLondon%2BEC2A%252C%2BUK&sensor=false")
		allow(GoogleDirections).to receive(:new).and_return(direction)

		allow(direction).to receive(:xml).and_return(GOOGLEDIRECTIONS_XML_RESPONSE)
	end

	it "is initialized with a start and a destination" do
		expect(gmaps.destination).to eq 'old street, london'
	end

	it "returns directions in XML format" do
		expect(gmaps.get_directions).to match Hash
	end

	it "returns a formatted list of directions" do
		expect(gmaps.directions_formatted).to include ('Turn <b>right</b> onto <b>City Rd/A501</b>')
	end

	it "can create a JSON hash for the printer" do 
		expect(gmaps.json).to eq [{:format=>"TEXT",:text=>"Head <b>east</b> on <b>Epworth St</b> toward <b>Tabernacle St</b>"},{:format=>"TEXT", :text=>"Turn <b>right</b> onto <b>Paul St</b>"},{:format=>"TEXT", :text=>"Turn <b>right</b> onto <b>Worship St</b>"},{:format=>"TEXT", :text=>"Turn <b>right</b> onto <b>City Rd/A501</b>"},{:format=>"TEXT",:text=>"At the roundabout, take the <b>1st</b> exit onto <b>Old St/A501/A5201</b><div style=\"font-size:0.9em\">Continue to follow Old St/A5201</div><div style=\"font-size:0.9em\">Leaving toll zone</div><div style=\"font-size:0.9em\">Entering toll zone</div>"}]
	end

end