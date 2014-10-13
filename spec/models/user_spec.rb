describe User do 

	context "a valid user" do 

		let(:albert) { User.create(email: "test@test.com", 
								   password: "oranges", 
								   password_confirmation: "oranges") }

		it "can be created in the database" do 
			albert
			expect(User.count).to eq 1
		end
	end

	context "a invalid user" do 
		let(:ben) { User.create(email: "test@test.com", 
								   password: "oranges", 
								   password_confirmation: "peaches") }

		it "as user with mismatched passwords cannot be created in the database" do 
			p ben.errors
			expect(ben.errors).not_to be_empty
		end
	end
end