require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference("Event.count") do
      post events_url, params: { event: { description: @event.description, event_date: @event.event_date, title: @event.title, time_limit_per_lt: 10, hashtag: "ruby" } }
    end

    assert_redirected_to event_url(Event.last)
    assert_equal 10, Event.last.time_limit_per_lt
    assert_equal "ruby", Event.last.hashtag
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should not create event with invalid parameters" do
    assert_no_difference("Event.count") do
      post events_url, params: { event: { title: "", event_date: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update event" do
    patch event_url(@event), params: { event: { description: @event.description, event_date: @event.event_date, title: @event.title, time_limit_per_lt: 7, hashtag: "update" } }
    assert_redirected_to event_url(@event)
    assert_equal 7, @event.reload.time_limit_per_lt
    assert_equal "update", @event.hashtag
  end

  test "should destroy event" do
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
