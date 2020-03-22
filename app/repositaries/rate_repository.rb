# frozen_string_literal: true

class RateRepository
  def initialize(data_source: Admin::Rate)
    @data_source = data_source
  end

  def find_active
    @data_source.where('finished_at > ?', DateTime.now).last
  end
end
