feature "User sign up" do

	context "a new user" do 

		scenario "when visiting the home page a sign up form is displayed" do
			visit '/'
			expect(page).to have_selector("form.sign_up")
		end

	end

end