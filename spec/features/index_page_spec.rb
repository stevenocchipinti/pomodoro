feature "Index page", js: true do

  let(:url) { "/" }
  let(:session_name) { "my-session" }
  let(:session_name_two) { "my-session-two" }

  before do
    Session.class_variable_set(:@@sessions, {})
    Session.new(session_name)
  end

  scenario "List all existing sessions" do
    Session.new(session_name_two)
    visit url
    expect(page).to have_content(session_name)
    expect(page).to have_content(session_name_two)
  end

  scenario "Delete an existing session" do
    visit url
    expect(page).to have_content(session_name)
    find("button.destroy").click
    expect(page).not_to have_content(session_name)
  end

end
