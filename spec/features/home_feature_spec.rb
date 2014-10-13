feature "For the first time a user visits the home page" do

	scenario "visiting the home page" do

		visit '/'

		expect(page).to have_content('Welcome to SparkPrint')
	end

end