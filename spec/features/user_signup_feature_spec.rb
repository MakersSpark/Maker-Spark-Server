feature "User sign up" do

	context "a new user" do 

		scenario "when visiting the home page a sign up form is displayed" do
			visit '/sign_up'
			expect(page).to have_selector("form.sign_up")
		end
		
		scenario "the form has the correct fields" do
			visit '/sign_up'
			expect(page).to have_selector("input[name=email]")
			expect(page).to have_selector("input[name=password]")
			expect(page).to have_selector("input[name=password_confirmation]")
			expect(page).to have_button("Sign up")
    end

    scenario "The user can sign up" do
    		visit '/sign_up'
			expect{ sign_up }.to change(User, :count).by(1)
			expect(current_path).to eq('/')
			expect(page).to have_content('Thank you for registering, byverdu@test.com')
			expect(page).to have_button('Log out')
			expect(User.first.email).to eq('byverdu@test.com')
    	end
	end

	


end


