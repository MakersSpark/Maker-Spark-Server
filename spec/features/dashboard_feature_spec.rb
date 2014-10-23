feature "using the dashboard" do	
	context "a signed in user on the homepage" do

		before do
				stub_printer("TEXT","hello world")
				stub_printer("TEXT","")
				stub_printer("TEXT","")
				stub_request(:any, "https://github.com/users/byverdu/contributions")
				visit '/'
				sign_up
				sign_in
				visit '/dashboard'
		end

		scenario "is logged in" do
			expect(page).to have_button('Log out')
		end

		scenario "sees welcome message and a form with the preferences" do
			expect(page).to have_css("form")
			expect(page).to have_content("Select what to print")
		end

		xscenario "sees a box for sending messages to the printer" do
			expect(page).to have_css('textarea[name=messagebox]')
		end


		xscenario "can see a printed successfully message, when message was sent to the printer" do 
			visit '/'
			fill_in('messagebox', with: 'hello world')
			click_button('Print')
			expect(page).to have_content("Successfully sent to the printer!")
		end

		xscenario "can send formatted text to the printer" do 
			visit '/'
			fill_in('messagebox', with: 'hello world')
			click_button('Print')
			expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello world/" })).to have_been_made
		end

		scenario "sees a checkbox populated with usernames" do
			visit '/'
			expect(page).to have_selector('.message-receiver')
			within(:css, '.message-receiver') {
				expect(page).to have_content('byverdu')
			}
		end

		scenario "have a box for sending messages to other users" do
			visit '/'
			expect(page).to have_css('textarea[name=usermessagebox]')
		end

		scenario "have a button for sending messages to other users" do	
			visit '/'
			expect(page).to have_button('Send message')
		end

		scenario "the user sees an unchecked boxes for all the possible preferences" do
			find(:css, "input[name='calendar']"   ).set(false)
			find(:css, "input[name='forecast']"   ).set(false)
			find(:css, "input[name='github_data']" ).set(false)
			find(:css, "input[name='twitter_data']").set(false)
			find(:css, "input[name='tube_status']" ).set(false)
		end

		scenario "a user checks the makers calendar and submits, he returns to the page and finds the makers calendar ckecked" do 
			find(:css, "input[name='calendar']"   ).set(true)
			click_button('Submit')
			visit '/dashboard'
			expect(find("input[name='calendar']")).to be_checked 
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
