# frozen_string_literal: true

module CurrencyConverter
  module Utils
    def symbolize_keys(array)
      array.each_with_object({}) do |(k, v), memo|
        memo[normalize_currency(k)] = v
      end
    end

    def normalize_currency(currency)
      currency.upcase.to_sym
    end
  end
end
