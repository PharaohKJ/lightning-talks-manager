require "test_helper"

class LightningTalksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should create lightning_talk via turbo stream" do
    assert_difference("LightningTalk.count") do
      post event_lightning_talks_url(@event), params: { lightning_talk: { speaker_name: "Speaker", title: "LT Title", duration: 10 } }, as: :turbo_stream
    end

    assert_response :success
    assert_equal 10, LightningTalk.last.duration
    assert_no_match /turbo-stream action="append" target="lightning_talks"/, response.body
    assert_match /turbo-stream action="replace" target="lightning_talk_form"/, response.body
  end

  test "should not create lightning_talk with invalid parameters via turbo stream" do
    assert_no_difference("LightningTalk.count") do
      post event_lightning_talks_url(@event), params: { lightning_talk: { speaker_name: "", title: "" } }, as: :turbo_stream
    end

    assert_response :success
    assert_match /turbo-stream action="replace" target="lightning_talk_form"/, response.body
  end

  test "should update position" do
    lt = @event.lightning_talks.create!(speaker_name: "Speaker", title: "LT", position: 1)
    patch event_lightning_talk_url(@event, lt), params: { position: 2 }
    assert_response :no_content
    assert_equal 2, lt.reload.position
  end
end
