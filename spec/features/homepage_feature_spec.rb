feature "A user visits the home page" do
	before do

	end

	scenario "sees a title containing a welcome message" do
		visit '/'
		expect(page).to have_content('Welcome to SparkPrint')
	end

	scenario "have a box for sending messages to the printer" do	
		visit '/'
		expect(page).to have_css('textarea[name=messagebox]')
	end

	scenario "visiting the home page" do
		visit '/'
		expect(page).to have_selector('button.print-hello-world')
	end

	scenario "can type in messages and send them to the printer" do
		stub_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").
    		with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/" })
		visit '/'
		fill_in('messagebox', with: 'hello world')
		click_button('Print')
		expect(a_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/" })).to have_been_made
	end
end

