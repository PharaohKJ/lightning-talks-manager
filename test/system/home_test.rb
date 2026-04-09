require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "visiting the root" do
    visit root_path
    assert_selector "h1", text: I18n.t("events.index.title")
  end
end
