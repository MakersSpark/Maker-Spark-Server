require 'spec_helper'
def app
  PrinterController.new
end

describe "PrinterController" do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:rfid_code) { "41d21cd" }
	let(:user) { double :user, id: 1, github_user: "benjamintillett"}
	let(:message) { double :message, content: "Hi, I love you!" }
	let(:tiny_url) {"http://tinyurl.com/3xc6c2"  }

	before do
		afternoon = Time.local(2014,10,23,15,31)
		Timecop.freeze(afternoon)
		allow(JsonHandler).to receive(:get_user_info).and_return(my_json)
		stub_tiny_url
		allow(ShortURL).to receive(:shorten).with("http://spark-print-staging.herokuapp.com/users/sign_up_with/#{rfid_code}", :tinyurl).and_return(tiny_url)
		GithubData.any_instance.stub(name: "byverdu", score_today: 3, longest_streak: 2, highscore: [11,12])
		stub_github(user.github_user)
	end

	describe "POST /" do 
		it "prints a message, if a user with the specific rfid_code exists" do
			allow(User).to receive(:first).with(:rfid_code => rfid_code).and_return(user)
			allow(user).to receive(:id).and_return(1)
			stub_afternoon_message(GithubData.new(user.github_user))
			stub_github(user.github_user)
			stub_printer("CENTRE","No messages today.")
			post "/"
			expect_afternoon_message_to_have_been_made
		end

		it "prints a url, if no user with that rfid_code exists" do
			stub_weather
			stub_printer("CENTRE","Please sign up at:")
			stub_printer("CENTRE", tiny_url)
			stub_printer("TEXT","")
			stub_printer("TEXT"," ")
			post "/"
			expect(a_http_request("CENTRE","Please sign up at:")).to have_been_made
			expect(a_http_request("CENTRE",tiny_url)).to have_been_made
		end

		it "prints a usermessage, if a user received a message" do
			allow(User).to receive(:first).with(:rfid_code => rfid_code).and_return(user)
			allow(user).to receive(:id).and_return(1)
			allow(UserMessage).to receive(:all).with(user_id: user.id).and_return([message])
			stub_afternoon_message(GithubData.new(user.github_user))
			stub_github(user.github_user)
		 	stub_printer("TEXT","#{user.github_user} sent:")
			stub_printer("TEXT", message.content)
			post "/"
			expect(a_http_request("TEXT","#{user.github_user} sent:")).to have_been_made
			expect(a_http_request("TEXT", message.content)).to have_been_made
		end
	end
end