# frozen_string_literal: true

class RateRepository
  def initialize(data_source: Admin::Rate)
    @data_source = data_source
  end

  def find_active
    record = @data_source.last
    record && record.finished_at > DateTime.now ? record : nil
  end
end
