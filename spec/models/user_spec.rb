describe User do 

	let(:options) { {"github" => true, "weather" => true, "tube_status" => false} }

	let(:albert) { create(:valid_user) }

	let(:options_hash) do 
			{Calendar: {print: true, option: nil},
			 Forecast: {print: true, option: nil}, 
			 GithubData: {print: true, option: nil}, 
			 TubeStatus: {print: true, option: nil}, 
			 TwitterData: {print: true, option: nil}, 
			 GuardianNews: {print: true, option: nil},
			 order: [:Calendar, :Forecast, :GithubData, :TubeStatus, :TwitterData, :GuardianNews]}
	end





	let(:ben) { User.create(email: "ben@test.com", 
							   password: "oranges", 
							   password_confirmation: "peaches") }

	let(:albert2) { create(:duplicate_user) }

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

	let(:message_receiver) { User.create(email: "benjamino@test.com",
	               rfid_code: '123124',
	               github_user: 'benjamintillett',
							   password: "oranges", 
							   password_confirmation: "oranges")}


User.create(email: "benjamino@test.com",
rfid_code: '123124',
github_user: 'benjamintillett',
password: "oranges", 
password_confirmation: "oranges")


	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
		stub_request(:any, "https://github.com/users/benjamintillett/contributions")
		stub_request(:any, "https://github.com/users/henryaj/contributions")
		stub_request(:any, "https://github.com/users//contributions").to_return(:status => 404)
		stub_request(:any, "https://github.com/users/vincentxyz/contributions").to_return(:status => 404)
	end

	context "a valid user" do 

		it "can be created in the database" do 
			albert
			expect(User.count).to eq 1
		end

		it "parses the options json into a hash" do
			albert
			expect(albert.options_hash.class).to eq Hash 
		end

		it " can save a hash as an options json" do 
			albert.options_hash = options
			expect(albert.options_hash).to eq options
		end

		it "has an 'options' field as Text" do
			albert
			albert.options = options 
			expect(albert.options).to eq(options)
		end

		it "has all preferences set to true on creation" do 
			expect(albert.options).to eq(options_hash.to_json)
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



	context "user preferences" do

		it "is can have a preference object" do 
			albert.preferences = Preferences.create
			expect(albert.preferences.class).to eq Preferences
		end



		# it "can change its preferences" do 
		# 	albert.preferences = Preferences.create
		# 	albert.preferences.set_options("ben")
		# 	expect(Preferences.first.options).not_to eq options_hash 
		# 	# p albert.preferences.save
		# 	# p albert.preferences.errors
		# 	# p Preferences.first
		# end

	end



	context "user sending messages" do
		it "can send messages to a second user" do
			UserMessage.create(content: "I love you!!!!", sender_id: albert.id, user_id: message_receiver.id)
			expect(UserMessage.first.content).to eq "I love you!!!!"
			expect(UserMessage.first.dirty?).to eq false
		end

		it "can delete all a user's messages" do
			UserMessage.create(content: "I love you!!!!", sender_id: albert.id, user_id: message_receiver.id)
			expect(UserMessage.first.content).to eq "I love you!!!!"
			albert.destroy_all_user_messages
			expect(albert.UserMessages.any?).to eq false
		end
	end
end