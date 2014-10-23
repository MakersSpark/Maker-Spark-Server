describe Preferences do

	let(:albert) { create(:valid_user) }
	let(:alberts_prefs) { Preferences.create(user_id: albert.id) }


	context "on instantiation it has" do 

		it "a user" do
			expect(alberts_prefs.user).to eq albert
		end

		it "calendar prefs " do 
			expect(alberts_prefs.calendar).to eq(false)
		end

		it "forecast prefs" do 
			expect(alberts_prefs.forecast).to eq(false) 
		end		

		it "github data prefs" do 
			expect(alberts_prefs.github_data).to eq(false) 
		end		

		it "twitter data prefs" do 
			expect(alberts_prefs.twitter_data).to eq(false) 
		end		

		it "tube status prefs" do 
			expect(alberts_prefs.tube_status).to eq(false) 
		end		

		it "guardian news prefs" do 
			expect(alberts_prefs.guardian_news).to eq(false) 
		end		

		it "an any empty github username filed" do 
			expect(alberts_prefs.github_username).to eq(nil) 
		end

		it "pragramming as a twitter search term" do 
			expect(alberts_prefs.twitter_search_term).to eq "programming" 
		end
	end

	context "changing preferences" do 

		it "can change the print options of its properties to true" do 
			alberts_prefs.calendar = true
			expect(alberts_prefs.calendar).to eq true	
		end

		it "can change the git hub username" do 
			alberts_prefs.github_username = "byverdu"
			expect(alberts_prefs.github_username).to eq "byverdu"
		end

	end
end