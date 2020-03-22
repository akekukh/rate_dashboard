class RateService
  FROM_RATE = :USD
  TO_RATE   = :RUB
  def self.find_rate
    resource = RateRepository.new.find_active.nil? ? :cbr : :static
    CurrencyConverter::Convert.new(resource).ratio(FROM_RATE, TO_RATE)
  end
end
