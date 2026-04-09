class Event < ApplicationRecord
  has_many :lightning_talks, -> { order(position: :asc) }, dependent: :destroy
  after_initialize :set_default_time_limit, if: :new_record?

  validates :title, presence: true
  validates :event_date, presence: true
  validates :time_limit_per_lt, presence: true, numericality: { only_integer: true, greater_than: 0 }

  private

  def set_default_time_limit
    self.time_limit_per_lt ||= 5
  end
end
