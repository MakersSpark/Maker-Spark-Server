feature "User sign in" do

	scenario "User is able to sign in" do
			visit '/'
			expect(page).to have_link('Sign in')
			click_link('Sign in')
			expect(current_path).to eq('/sign_in')
	end

	scenario "User signs in" do
			sign_up
			sign_in
			expect(current_path).to eq('/')
	end
end

feature "Users log out" do

	before(:each) do
		sign_up
		sign_in
	end

	scenario "A user can log out after signed in" do
		click_button('Log out')
		expect(page).to have_content("Good bye!")
	end
end