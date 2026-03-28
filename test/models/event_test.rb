require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "should be valid with title and event_date" do
    event = Event.new(title: "Test Event", event_date: Time.current)
    assert event.valid?
  end

  test "should be invalid without title" do
    event = Event.new(event_date: Time.current)
    assert_not event.valid?
    assert_includes event.errors[:title], "can't be blank"
  end

  test "should be invalid without event_date" do
    event = Event.new(title: "Test Event")
    assert_not event.valid?
    assert_includes event.errors[:event_date], "can't be blank"
  end
end
