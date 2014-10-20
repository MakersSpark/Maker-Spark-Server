include SpecHelpers

describe GuardianNews do

	let(:news) {GuardianNews.new}

	context "getting news headlines" do
		
		it "returns latest news in JSON format" do
			stub_news
			expect(news.get_newsstories).to eq JSON.parse(GUARDIANNEWS_JSON_RESPONSE)
			
		end
		
		it "returns a list of only the headlines" do
			stub_news
			expect(news.headlines).to eq ("Dowler family ‘horrified’ if Sun body story came from police tipoff, trial hears")
		end

	end

end