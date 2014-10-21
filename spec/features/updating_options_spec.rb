feature "Users changing their print settings" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
		sign_in
	end

	xscenario "checking all the boxes and press submit changes that user's database entry" do
		visit '/dashboard'
		check 'Calendar'
		check 'Forecast'
		check 'GitHubData'
		check 'TubeStatus'
		check 'TwitterData'
		check 'GuardianNews'
		click_button 'Submit'
		expect(User.first.options).to eq(
			{Calendar: {print: true, option: nil},
			 Twitter: {print: true, option: nil}, 
			 Forecast: {print: true, option: nil}, 
			 GitHubData: {print: true, option: nil}, 
			 TubeStatus: {print: true, option: nil}, 
			 TwitterData: {print: true, option: nil}, 
			 GuardianNews: {print: true, option: nil},
			 order: [:Calendar, :Forecast, :GitHubData, :TubeStatus, :TwitterData, :GuardianNews]}
			 )
	end

	xscenario "unchecking all the boxes and press submit changes that user's database entry" do
		visit '/dashboard'
		uncheck 'Calendar'
		uncheck 'Forecast'
		uncheck 'GitHubData'
		uncheck 'TubeStatus'
		uncheck 'TwitterData'
		uncheck 'GuardianNews'
		click_button 'Submit'
		p page.body
		expect(User.find(email:'byverdu@test.com').options).to eq(
			{Calendar: {print: false, option: nil},
			 Twitter: {print: false, option: nil}, 
			 Forecast: {print: false, option: nil}, 
			 GitHubData: {print: false, option: nil}, 
			 TubeStatus: {print: false, option: nil}, 
			 TwitterData: {print: false, option: nil}, 
			 GuardianNews: {print: false, option: nil},
			 order: [:Calendar, :Forecast, :GitHubData, :TubeStatus, :TwitterData, :GuardianNews]}
			 )
	end

end