class RateService
  FROM_RATE = :USD
  TO_RATE   = :RUB
  def self.find_rate
    static_rate = RateRepository.new.find_active
    static_rate.nil? ? CurrencyConverter::Convert.new(:cbr).ratio(FROM_RATE, TO_RATE) : static_rate.rate
  end
end
