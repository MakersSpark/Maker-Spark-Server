feature "a guest on the home page" do
	before do
		stub_printer("TEXT","hello world")
		stub_printer("TEXT","")
		stub_printer("TEXT","")
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		create(:valid_user)
	end

	scenario "sees a title containing a welcome message" do
		visit '/'
		expect(page).to have_content('SparkPrint')
	end

	scenario "have a box for sending messages to the printer" do	
		visit '/'
		expect(page).to have_css('textarea[name=messagebox]')
	end


	scenario "can see a printed successfully message, when message was sent to the printer" do 
		visit '/'
		fill_in('messagebox', with: 'hello world')
		click_button('Print')
		expect(page).to have_content("Successfully sent to the printer!")
	end

	scenario "a visitor can see the sign in and sign up" do
		visit '/'
		expect(page).to have_link('Sign in')
		expect(page).to have_link('Sign up')
		expect(page).not_to have_button('Log out')
		expect(page).not_to have_link('Edit account')	
	end

	scenario "can send formatted text to the printer" do 
		visit '/'
		fill_in('messagebox', with: 'hello world')
		click_button('Print')
		expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello world/" })).to have_been_made
	end

end

feature "a signed in user on the homepage" do

	before do
		stub_printer("TEXT","hello world")
		stub_printer("TEXT","")
		stub_printer("TEXT","")
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
		sign_in
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

end

