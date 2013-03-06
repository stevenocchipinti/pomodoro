describe "Pomodoro timer", js: true, type: :request do

  def current_countdown
    find("#countdown").text.sub(":", ".").to_f
  end

  describe "Multi-user synchronisation via WebSockets" do

    let(:url) { "/test" }

    it "starts the timer when another client clicks 'start'" do
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
      current_countdown.should < initial_countdown
      page.should have_content "Stop"
    end

  end
end
