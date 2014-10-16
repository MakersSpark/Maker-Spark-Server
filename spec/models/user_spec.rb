describe User do 


	let(:albert) { User.create(email: "albert@test.com",
	               rfid_code: '41d21cd', 
							   password: "oranges", 
							   password_confirmation: "oranges") }

	let(:ben) { User.create(email: "ben@test.com", 
							   password: "oranges", 
							   password_confirmation: "peaches") }

	let(:albert2) { User.create(email: "albert@test.com", 
								   password: "oranges", 
								   password_confirmation: "oranges") }


	let(:vincent) { User.create(email: "test.test.com", 
							   password: "oranges", 
							   password_confirmation: "peaches") }

	let(:kevin) { User.create(email: "",
							  password: "",
							  password_confirmation: ""	) }



	context "a valid user" do 

		it "can be created in the database" do 
			albert
			expect(User.count).to eq 1
		end
	end

	context "a invalid user" do
		it "as user with mismatched passwords cannot be created in the database" do 
			expect(ben.errors[:password]).to eq ["Password does not match the confirmation"]
		end

		it "as user with a non valid email cannot be created in the database" do
			expect(vincent.errors[:email]).to eq ["Email has an invalid format"]
		end

		it "as user with blank email address" do
			expect(kevin.errors[:email]).to eq ["Email must not be blank"]
		end


		it "as user with blank passwords" do
			expect(kevin.errors[:password]).to eq ["Password must be at least 1 characters long"]
		end

		it "as user with blank password confirmation" do
			expect(kevin.errors[:password_confirmation]).to eq ["Password confirmation must be at least 1 characters long"]
		end
	end

	context "a duplicate user" do 
		it "two users cant have the same email address" do 
			albert
			expect(albert2).not_to be_valid
		end
	end
end