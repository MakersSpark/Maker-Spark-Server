feature "User sign up" do

	context "a new user" do 

		scenario "when visiting the home page a sign up form is displayed" do
			visit '/'
			expect(page).to have_selector("form.sign_up")
		end
		scenario "the form needs to have all this fields" do
			visit '/'

			expect(page).to have_selector("input[name=username]")
			expect(page).to have_selector("input[name=password]")
			expect(page).to have_button("Submit")
    end
	end

end