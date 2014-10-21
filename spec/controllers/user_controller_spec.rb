require 'spec_helper'
require 'rack/test'
include Rack::Test::Methods
include UserHelper

ENV['RACK_ENV'] = 'test'

def app
  UsersController.new
end


xdescribe "user controller" do 

	before do
		stub_request(:any, "https://github.com/users/byverdu/contributions")
	end 

	let(:henry) { User.create(email: "henry@test.com", 
		               		  github_user: 'byverdu',
						      password: "oranges", 
						      password_confirmation: "oranges") }


	let(:options_params) { { github: true, weather: false } }

	it "can set user options from params posted to update" do 
		henry # creates user henry
		
		# get '/', {}, 'rack.session' => session
		# browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
		response = get '/update', {}, 'rack.session' => {user_id: henry.id}
		puts response.inspect
		# browser.post '/update', options: { github: true }, 'rack.session' => session
		
		# expect(henry.options).to eq(options_params) 
	end



end