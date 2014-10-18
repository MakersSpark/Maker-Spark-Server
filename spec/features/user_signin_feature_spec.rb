feature "User sign in" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
	end


	scenario "User is able to sign in" do
			visit '/'
			expect(page).to have_link('Sign in')
			click_link('Sign in')
			expect(current_path).to eq('/sign_in')
	end

	scenario "User signs in" do
			sign_up
			expect(page).to have_content('Thank you for registering, byverdu@test.com')
			sign_in
			expect(current_path).to eq('/')
			expect(page).not_to have_content('Thank you for registering, byverdu@test.com')
			expect(page).to have_content('Welcome back byverdu@test.com')
	end
end

feature "Users log out" do



	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
		sign_in
	end

	scenario "A user can log out after signed in" do
		click_button('Log out')
		expect(page).to have_content("Good bye!")
	end
end

feature "Error messages when signing in" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
	end

	scenario "with the wrong email" do

		wrong_sign_in('byve@test.com','s3cr3t')

		expect(page).to have_content("We couldn't find that email address – make sure it's typed correctly.")
	end

	scenario "with the wrong password" do
		wrong_sign_in('byverdu@test.com','s3cr3t0')
		expect(page).to have_content("There's something wrong with your password.")
	end

end