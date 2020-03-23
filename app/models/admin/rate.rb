class Admin::Rate < ApplicationRecord
  after_save do
    ChangeRateJob.set(wait_until: finished_at).perform_later
    ActionCable.server.broadcast 'rate_notifications_channel', rate: RateService.find_rate
  end
end
