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
			expect(current_path).to eq('/sign_up')
			expect{ sign_up }.to change(User, :count).by(1)
   			expect(page).to have_content('Welcome to SparkPrint Print')
			expect(User.first.email).to eq('byverdu@test.com')
    	end
	end

end

def sign_up(email                 =  'byverdu@test.com',
	          password              = 's3cr3t',
	          password_confirmation = 's3cr3t')

	visit '/sign_up'

	fill_in 'email', with: email
	fill_in 'password', with: password
	fill_in 'password_confirmation', with: password_confirmation

	click_button 'Sign up'
end
