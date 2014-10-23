describe Preferences do
	
	let(:albert) { double :user, id: 1 }

	let(:options_hash) do  
		    {Calendar: {print: true, option: nil},
			 Forecast: {print: true, option: nil}, 
			 GithubData: {print: true, option: nil}, 
			 TubeStatus: {print: true, option: nil}, 
			 TwitterData: {print: true, option: nil}, 
			 GuardianNews: {print: true, option: nil},
			 order: [:Calendar, :Forecast, :GithubData, :TubeStatus, :TwitterData, :GuardianNews]} 			 
	end 

	let(:options_with_username) do  
		    {Calendar: {print: true, option: nil},
			 Forecast: {print: true, option: nil}, 
			 GithubData: {print: true, option: "byverdu"}, 
			 TubeStatus: {print: true, option: nil}, 
			 TwitterData: {print: true, option: nil}, 
			 GuardianNews: {print: true, option: nil},
			 order: [:Calendar, :Forecast, :GithubData, :TubeStatus, :TwitterData, :GuardianNews]}.to_json 			 
	end 

	let(:options_json) { options_hash.to_json } 

	let(:alberts_preferences) { Preferences.create(user_id: albert.id, options: options_json) }


		it "can be created in the database" do 
			alberts_preferences
			expect(Preferences.count).to eq 1
		end

		it "can have a user" do
			alberts_preferences.user = albert
			expect(alberts_preferences.user).to eq albert
		end

		it "has a json of options" do 
			expect(alberts_preferences.options).to eq options_json
		end

		it "parses the options json into a hash" do
			expect(alberts_preferences.options_hash.class).to eq Hash 
		end

		it " can save a hash as an options json" do 
			alberts_preferences.options_hash = options_hash
			expect(alberts_preferences.options).to eq options_json
		end

		it "can update a user preference" do 
			alberts_preferences.update_option("GithubData", "print", false)
			expect(alberts_preferences.options_hash["GithubData"]).to eq({ "print" => false, "option" => nil })
		end

		it "can set the options" do
			alberts_preferences.set_options("byverdu")
			expect(Preferences.first.options).to eq options_with_username
		end

end