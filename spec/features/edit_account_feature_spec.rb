feature "Editing a user account" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		stub_request(:any, "https://github.com/users/henryaj/contributions")
		sign_up
		sign_in
		visit "/edit_user"	
	end

	scenario "should be able to see the form" do

		expect(current_path).to eq('/edit_user')
		expect(page).to have_selector("form.edit_user")
		expect(page).to have_content('Editing the account')
	end

	scenario "Email and github user will be displayed" do

		expect(current_path).to eq('/edit_user')
		expect(page).to have_xpath("//input[@value='byverdu@test.com']")
		expect(page).to have_xpath("//input[@value='byverdu']")
	end

	scenario "can change all his personal details" do
		editing_user
		
		expect(page).to have_content('Your details have been successfully updated')
		expect(current_path).to eq('/')
	end

	scenario "clicking on Home button leads to the home page" do
		visit "/edit_user"
		expect(page).to have_link('Home')
		click_link('Home')
		expect(current_path).to eq('/')
	end

end