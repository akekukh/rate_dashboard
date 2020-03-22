class RateController < ApplicationController
  def index
    @rate =  CurrencyConverter::Convert.new(:cbr).convert(1, 'USD', 'RUB').to_f
  end
end
