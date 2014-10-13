describe User do 

	context "a valid user" do 

		let(:albert) { User.create(email: "test@test.com", 
								   password: "oranges", 
								   password_confirmation: "oranges") }

		it "created in the database" do 
			albert
			expect(User.count).to eq 1
		end
	end
end