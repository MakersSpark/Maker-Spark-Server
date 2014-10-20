describe UserMessage do 

	let(:sending_user) { double :user, id: 1 }
	let(:receiving_user) { create(:valid_user) }
	let(:message) { UserMessage.create(content: "Hi there, wanna pair tomorrow?", sender_id: sending_user.id, user_id: receiving_user.id) }
	let(:too_long_message) { UserMessage.create(content: "Acceptance tests for your application may require that a test user be logged in. To do this in your application you can either sign in the user using capybara by visiting the sign in url and entering valid credentials", sender_id: sending_user.id ) }
	let(:no_sender_id_message) { UserMessage.create(content: "F*** YOU!" ) }

	before do 
		User.stub_chain(:first,:user_messages,:first,:content).and_return("Hi there, wanna pair tomorrow?")
	end

	context "creating messages" do 
		it "should be able to be created and saved to the database" do
			expect(message.content).to eq ("Hi there, wanna pair tomorrow?")
		end

		it "has a sender id" do 
			expect(message.sender_id).to eq 1
		end

		it "belongs to a user" do 
			expect(message.user_id).to eq receiving_user.id
		end
	end

	context "invalid message" do
		it "returns an error, if the message is longer than 128 characters" do
			expect(too_long_message.errors[:content]).to eq ["Content must be at most 128 characters long"]
		end

		it "must have a sender id" do 
			expect(no_sender_id_message.errors[:sender_id]).to eq ["Sender must not be blank"]
		end
	end
end