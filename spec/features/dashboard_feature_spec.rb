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

		xscenario "is logged in" do
			expect(page).to have_button('Log out')
		end

		scenario "the user sees a weather icon on the dashboard page" do
			expect(page).to have_css("img[src*='cloud.svg']")
		end

		xscenario "the user sees an unchecked weather selector" do
			find(:css, "#test[name='weather']").set(false)
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