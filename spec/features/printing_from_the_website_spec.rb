feature "printing from the website" do 

  context "a guest prints a message from the website" do

    scenario "successfully sending a message to the printer" do
      visit '/'
      fill_in('messagebox', with: 'hello world')
      stub_printer('TEXT', 'hello world')
      stub_printer('TEXT', '')
      stub_printer('TEXT', '')
      click_button('Print')
      expect(a_http_request('TEXT', 'hello world')).to have_been_made
      expect(page).to have_text("Successfully sent to the printer!")
    end

    scenario "unsuccessfully sending a message to the printer when it is offline" do
      visit '/'
      fill_in('messagebox', with: 'hello world')
      stub_offline_printer('TEXT', 'hello world')
      stub_offline_printer('TEXT', '')
      stub_offline_printer('TEXT', '')
      click_button('Print')
      expect(a_http_request('TEXT', 'hello world')).to have_been_made
      expect(page).to have_text("Sorry, something went wrong. Check the printer is online.")
    end

    scenario "guests cannot send messages to other users" do
      visit '/'
      expect(page).not_to have_css("textarea[name='usermessagebox']")
    end

  end
  
end