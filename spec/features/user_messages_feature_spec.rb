feature "User sends messages to another user" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		stub_request(:any, "https://github.com/users/peter123/contributions")
		User.create(email: "peter@test.com",rfid_code: '41d21cd',github_user: 'peter123', password: "oranges", password_confirmation: "oranges")
		sign_up

	end

	scenario "A user chooses the name of the receiver in a select box" do
		visit '/'
		select 'peter123', :from => 'receiver'
		fill_in('usermessagebox', with: 'Hi there asdasdasd!!!!')
		click_button('Send Message')
		expect(page).to have_content("Message has been sent!")
	end

end