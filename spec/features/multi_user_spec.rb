feature "Multiple user/session synchronisation", js: true do

  let(:url) { "/?session=test" }

  scenario "Timers are synchronised between clients" do
    Capybara.session_name = "Alice"
    visit url
    expect(page).to have_content "Start"
    initial_countdown = current_countdown

    Capybara.session_name = "Bob"
    visit url
    expect(page).to have_content "Start"
    fill_in "minutes", with: 1
    click_button "Start"
    sleep 3
    expect(page).to have_content "Stop"

    sleep 1

    Capybara.session_name = "Alice"
    expect(current_countdown).to be < initial_countdown
    expect(page).to have_content "Stop"
    click_button "Stop"
    expect(page).to have_content "Start"
    stopped_countdown = current_countdown

    Capybara.session_name = "Alice"
    expect(page).to have_content "Start"
    expect(current_countdown).to eq(stopped_countdown)
  end

  def current_countdown
    find("#countdown").text.sub(":", ".").to_f
  end

end
