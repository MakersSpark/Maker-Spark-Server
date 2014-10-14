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
			expect(page).to have_button("Sign")
    	end
	end

end