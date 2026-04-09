require "test_helper"

class LightningTalkTest < ActiveSupport::TestCase
  setup do
    @event = events(:one)
  end

  test "should be valid with speaker_name, title and duration" do
    lt = @event.lightning_talks.build(speaker_name: "Speaker", title: "LT Title", duration: 5)
    assert lt.valid?
  end

  test "should have default duration from event" do
    lt = @event.lightning_talks.build
    assert_equal @event.time_limit_per_lt, lt.duration
  end

  test "should be invalid with non-positive duration" do
    lt = @event.lightning_talks.build(speaker_name: "Speaker", title: "LT Title", duration: 0)
    assert_not lt.valid?
    lt.duration = -1
    assert_not lt.valid?
  end

  test "should be invalid without speaker_name" do
    lt = @event.lightning_talks.build(title: "LT Title")
    assert_not lt.valid?
    assert_includes lt.errors[:speaker_name], I18n.t("errors.messages.blank")
  end

  test "should be invalid without title" do
    lt = @event.lightning_talks.build(speaker_name: "Speaker")
    assert_not lt.valid?
    assert_includes lt.errors[:title], I18n.t("errors.messages.blank")
  end

  test "should be invalid without event" do
    lt = LightningTalk.new(speaker_name: "Speaker", title: "LT Title")
    assert_not lt.valid?
    assert_not_nil lt.errors[:event]
  end

  test "should maintain position" do
    lt1 = @event.lightning_talks.create!(speaker_name: "S1", title: "T1")
    lt2 = @event.lightning_talks.create!(speaker_name: "S2", title: "T2")
    
    assert_equal 1, lt1.position
    assert_equal 2, lt2.position
    
    lt2.move_higher
    assert_equal 1, lt2.reload.position
    assert_equal 2, lt1.reload.position
  end
end
