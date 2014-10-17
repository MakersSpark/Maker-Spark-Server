describe User do 


	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		stub_request(:any, "https://github.com/users/henryaj/contributions")
		stub_request(:any, "https://github.com/users//contributions").to_return(:status => 404)
		stub_request(:any, "https://github.com/users/vincentxyz/contributions").to_return(:status => 404)
	end

	let(:albert) { User.create(email: "albert@test.com",
	               rfid_code: '41d21cd',
	               github_user: 'byverdu', 
							   password: "oranges", 
							   password_confirmation: "oranges") }

	let(:ben) { User.create(email: "ben@test.com", 
							   password: "oranges", 
							   password_confirmation: "peaches") }

	let(:albert2) { User.create(email: "albert@test.com", 
								   password: "oranges", 
								   password_confirmation: "oranges") }

	let(:henry) { User.create(email: "henry@test.com", 
		               github_user: 'byverdu',
								   password: "oranges", 
								   password_confirmation: "oranges") }


	let(:vincent) { User.create(email: "test.test.com", 
							   password: "oranges", 
							   password_confirmation: "peaches") }

	let(:vincent_wrong_github) { User.create(github_user: 'vincentxyz') }

	let(:kevin) { User.create(email: "",
		            github_user: "",
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

		it "as user with blank github account" do
			expect(kevin.errors[:github_user]).to eq ["Github user must not be blank", "This github user doesn't exist"]
		end


		it "as user with blank passwords" do
			expect(kevin.errors[:password]).to eq ["Password must be at least 1 characters long"]
		end

		it "as user with blank password confirmation" do
			expect(kevin.errors[:password_confirmation]).to eq ["Password confirmation must be at least 1 characters long"]
		end


		it "as user with non existent github account" do
			expect(vincent_wrong_github.errors[:github_user]).to eq ["This github user doesn't exist"]
		end
	end

	context "editing user account" do

		it "a user can edit his details" do
				albert

				albert.update(email: "byberdu@test.com",
			               github_user: 'henryaj', 
									   password: "bananas", 
									   password_confirmation: "bananas")

				expect(albert.email).not_to eq('albert@test.com')
				expect(albert.github_user).not_to eq('byverdu8')
				expect(albert.password).not_to eq('oranges')
			end		
	end

	context "a duplicate user" do 
		it "two users cant have the same email address" do 
			albert
			expect(albert2).not_to be_valid
		end

		it "two users cant have the same github user" do 
			albert
			expect(henry).not_to be_valid
		end
	end
end