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
		expect(page).to have_content('Spark Printer')
	end

	scenario "a visitor can see the sign in button" do
		visit '/'
		expect(page).to have_link('Sign in')
		expect(page).not_to have_button('Log out')
		expect(page).not_to have_link('Edit account')	
	end


end