feature "A user visits the home page" do
	before do
		stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello world/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
	end

	scenario "sees a title containing a welcome message" do
		visit '/'
		expect(page).to have_content('Welcome to SparkPrint')
	end

	scenario "have a box for sending messages to the printer" do	
		visit '/'
		expect(page).to have_css('textarea[name=messagebox]')
	end

	

	# scenario "can see a printed successfully message, when message was sent to the printer" do 
	# 	visit '/'
	# 	#select 'Plain Text', :from => 'formatbox'
	# 	fill_in('messagebox', with: 'hello world')
	# 	click_button('Print')
	# 	expect(page).to have_content("Successfully sent to the printer!")
	# end

	scenario "a visitor can see the sign in and sign up" do
		visit '/'

		expect(page).to have_link('Sign in')
		expect(page).to have_link('Sign up')
		expect(page).not_to have_button('Log out')
		expect(page).not_to have_link('Edit account')	
	end

	# scenario "can send formatted text to the printer" do 
	# 	stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
	# 	with(:body => { access_token: ENV['SPARK_TOKEN'], args: "BOLD=hello world/" }).to_return(:body => "{\n  \"id\": \"50ff75065067545639190387\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
	# 	visit '/'
	# 	select 'Bold', :from => 'formatbox'
	# 	fill_in('messagebox', with: 'hello world')
	# 	click_button('Print')
	# 	expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "BOLD=hello world/" })).to have_been_made
	# end

end

