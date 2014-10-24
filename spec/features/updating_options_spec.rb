feature "Users changing their print settings" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
		sign_in
	end

	scenario "unchecking all the boxes and press submit changes that user's database entry" do
		visit '/dashboard'
		uncheck 'Calendar'
		uncheck 'Forecast'
		uncheck 'GithubData'
		uncheck 'TubeStatus'
		check 'TwitterData'
		check 'GuardianNews'
		click_button 'Submit'
		expect(Preferences.first.twitter_data).to eq true
		expect(Preferences.first.guardian_news).to eq true
		expect(Preferences.first.tube_status).to eq false

	end

	scenario "a user presses submit and sees a message confirming their options have been saved" do
		visit '/dashboard'
		click_button 'Submit'
		expect(page).to have_content("Thanks – your preferences have been saved.")
	end

	scenario "a user presses submit and is taken back to the dashboard" do
		visit '/dashboard'
		click_button 'Submit'
		expect(current_path).to eq('/dashboard')
	end

end