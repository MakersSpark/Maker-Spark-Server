feature "using the dashboard" do
	
	context "when logged in" do

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

		scenario "the user sees welcome message and a form with the preferences" do
			expect(page).to have_css("form")
			expect(page).to have_content("Select what you want to print")
		end

		scenario "the user sees an unchecked boxes for all the possible preferences" do
			find(:css, "input[name='Calendar']"   ).set(false)
			find(:css, "input[name='Forecast']"   ).set(false)
			find(:css, "input[name='GitHubData']" ).set(false)
			find(:css, "input[name='TwitterData']").set(false)
			find(:css, "input[name='TubeStatus']" ).set(false)
		end
	
	end

	context "when not logged in" do
		scenario "the user is redirected to the login page and shown an error" do
			visit '/dashboard'
			expect(page).to have_content("Sorry, you need to sign in or sign up before doing that.")
			expect(current_path).to eq('/users/sign_in')
		end
	end
end
