feature "Multiple user/session synchronisation", js: true do

  let(:url) { "/?session=test" }

  scenario "Timers are synchronised between clients" do
    Capybara.session_name = "Alice"
    visit url
    page.should have_content "Start"
    initial_countdown = current_countdown

    Capybara.session_name = "Bob"
    visit url
    page.should have_content "Start"
    fill_in "minutes", with: 1
    click_button "Start"
    page.should have_content "Stop"

    sleep 1

    Capybara.session_name = "Alice"
    current_countdown.should be < initial_countdown
    page.should have_content "Stop"
    click_button "Stop"
    page.should have_content "Start"
    stopped_countdown = current_countdown

    Capybara.session_name = "Alice"
    page.should have_content "Start"
    current_countdown.should == stopped_countdown

  end

  def current_countdown
    find("#countdown").text.sub(":", ".").to_f
  end

end
