class Admin::Rate < ApplicationRecord
  validates :finished_at, presence: true
  validates_numericality_of :rate, greater_than_or_equal_to: 0, allow_nil: false

  after_save do
    ChangeRateJob.set(wait_until: finished_at).perform_later
    ActionCable.server.broadcast 'rate_notifications_channel', rate: RateService.find_rate
  end

  def finished_at_validation
    errors.add(:finished_at, 'must be a valid datetime') if (begin
                                                                DateTime.parse(finished_at)
                                                             rescue StandardError
                                                               ArgumentError
                                                              end) == ArgumentError
  end
end
