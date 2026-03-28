require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "should create event" do
    visit events_url
    click_on "New event"

    fill_in "Title", with: "New Event"
    fill_in "Description", with: "Event Description"
    # Event date is a datetime field, usually rails uses multiple selects for it.
    # But scaffold might use a datetime-local input or something else.
    # Let's check how it's rendered.
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "should update Event" do
    @event = events(:one)
    visit event_url(@event)
    click_on "Edit this event", match: :first

    fill_in "Title", with: "Updated Title"
    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "should destroy Event" do
    @event = events(:one)
    visit events_url
    assert_text @event.title
    
    # We added button_to "Destroy this event" in index.html.erb
    click_on "Destroy this event", match: :first

    assert_text "Event was successfully destroyed"
  end
end
