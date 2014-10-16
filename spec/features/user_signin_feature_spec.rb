feature "User sign in" do

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
		sign_up
	end

	scenario "with the wrong email" do

		wrong_sign_in('by@test.com','s3cr3t')

		expect(page).to have_content('This email is not registered')
	end

	scenario "with the wrong password" do

		wrong_sign_in('byverdu@test.com','s3cr3t0')

		expect(page).to have_content('This password is wrong')
	end

end