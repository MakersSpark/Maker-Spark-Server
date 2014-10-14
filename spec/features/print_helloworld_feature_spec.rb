feature "A user can visit the homepage and print 'hello world'" do

	scenario "visiting the home page" do
		visit '/'
		expect(page).to have_selector('button.print-hello-world')
	end

	scenario "clicking the print hello world button" do 
		
		stub_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").
    	with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello/" }).to_return(:body => "{\n  \"id\": \"50ff75065067545639190387\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")

		visit '/'
		click_button('Print')
	end

end
