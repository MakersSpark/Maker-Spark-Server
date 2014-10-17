feature "User sends messages to another user" do

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		sign_up
	end


	scenario "A user chooses the name of the receiver in a select box" do
		visit '/'

	end

end