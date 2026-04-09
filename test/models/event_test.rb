require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "should be valid with title and event_date" do
    event = Event.new(title: "Test Event", event_date: Date.today)
    assert event.valid?
  end

  test "should be invalid without title" do
    event = Event.new(event_date: Date.today)
    assert_not event.valid?
    assert_includes event.errors[:title], I18n.t("errors.messages.blank")
  end

  test "should be invalid without event_date" do
    event = Event.new(title: "Test Event")
    assert_not event.valid?
    assert_includes event.errors[:event_date], I18n.t("errors.messages.blank")
  end

  test "should have default time_limit_per_lt of 5" do
    event = Event.new
    assert_equal 5, event.time_limit_per_lt
  end

  test "should be invalid with non-integer or non-positive time_limit_per_lt" do
    event = Event.new(title: "Test", event_date: Date.today, time_limit_per_lt: 0)
    assert_not event.valid?
    event.time_limit_per_lt = -1
    assert_not event.valid?
    event.time_limit_per_lt = "abc"
    assert_not event.valid?
  end
end
