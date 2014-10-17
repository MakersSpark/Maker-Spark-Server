feature "printing from the website" do 

  context "a user prints a message from the website" do

    scenario "successfully sending a message to the printer" do
      visit '/'
      fill_in('messagebox', with: 'hello world')
      stub_printer('TEXT', 'hello world')
      click_button('Print')
      expect(a_http_request('TEXT', 'hello world')).to have_been_made
      expect(page).to have_text("Successfully sent to the printer!")
    end

    scenario "unsuccessfully sending a message to the printer when it is offline" do
      visit '/'
      fill_in('messagebox', with: 'hello world')
      stub_offline_printer('TEXT', 'hello world')
      click_button('Print')
      expect(a_http_request('TEXT', 'hello world')).to have_been_made
      expect(page).to have_text("Sorry, something went wrong. Is the printer online?")
    end

  end
  
end