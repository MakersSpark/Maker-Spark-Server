feature "using the dashboard" do
	before do
			stub_request(:any, "https://github.com/users/byverdu/contributions")
			visit '/'
			sign_up
			expect(page).to have_content('Thank you for registering, byverdu@test.com')
			expect(current_path).to eq('/')
			visit '/dashboard'
	end

	scenario "is logged in" do
		expect(page).to have_button('Log out')
	end

	scenario "sees a weather icon on the dashboard page" do
		expect(page).to have_css("img[src*='cloud.svg']")
	end

	xscenario "the user sees an unchecked weather selector" do
		find(:css, "#test[value='weather']").set(false)
	end
	
end
