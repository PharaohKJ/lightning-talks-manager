class LightningTalk < ApplicationRecord
  belongs_to :event
  acts_as_list scope: :event
  validates :speaker_name, presence: true
  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }

  after_initialize :set_default_duration, if: :new_record?

  broadcasts_to :event, inserts_by: :append, target: "lightning_talks"
  after_commit :broadcast_position_update, on: :update, if: :saved_change_to_position?

  private

  def set_default_duration
    return unless event && duration.nil?
    self.duration = event.time_limit_per_lt
  end

  def broadcast_position_update
    broadcast_replace_to event, target: "lightning_talks", partial: "lightning_talks/list", locals: { event: event }
  end
end
