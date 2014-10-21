describe GuardianNews do

	let(:news) {GuardianNews.new}

	before do
		stub_news

	end
	context "getting news headlines" do
		
		it "returns latest news in JSON format" do
			expect(news.get_newsstories).to eq JSON.parse(GUARDIANNEWS_JSON_RESPONSE)
			
		end

		it "returns a list of headlines and formatted date of publication" do
			expect(news.headlines).to include({webtitle: "Dowler family ‘horrified’ if Sun body story came from police tipoff, trial hears", publication_date: "20 October, 13:26"})
		end
	end

	it "can create a JSON hash for the printer" do 
		expect(news.json).to eq [{:format=>"TEXT",:text=>"Dowler family ‘horrified’ if Sun body story came from police tipoff, trial hears (20 October, 13:26)"},{:format=>"TEXT",:text=>"Blaze engulfs Didcot B power station in Oxfordshire (20 October, 01:16)"},{:format=>"TEXT",:text=>"Inquiries continue two years after UK given list of suspected paedophiles (19 October, 23:05)"}]
	end

end