describe UserMessage do 
	context "creating messages" do 
		it "should be able to be created and saved to the databse" do
			message = UserMessage.create(content: "Hi there, wanna pair tomorrow?")
			expect(message.content).to eq ("Hi there, wanna pair tomorrow?")
		end
	end
end