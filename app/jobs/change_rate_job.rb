class ChangeRateJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    ActionCable.server.broadcast 'rate_notifications_channel', rate: RateService.find_rate
  end
end
