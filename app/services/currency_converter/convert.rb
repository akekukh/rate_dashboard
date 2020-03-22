# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'currency_converter/utils'

module CurrencyConverter
  class Convert
    class UnknownCurrencyError < StandardError; end

    include CurrencyConverter::Utils

    attr_reader :provider

    def initialize(provider = :cbr, accuracy = 10)
      @provider = load_provider(provider)
      @accuracy = accuracy
      @chain = [] << @provider
      yield(self) if block_given?
    end

    def add(middleware)
      middleware.prev = @chain.last
      @chain << middleware
    end

    def rates
      symbolize_keys(@chain.last.call)
    end

    def rate(currency)
      currency = normalize_currency(currency)
      rate = rates[currency]
      raise UnknownCurrencyError, I18n.t('currency_converter.unknown_currency', currency: currency) unless rate

      round(BigDecimal(rate.sub(',', '.'), @accuracy))
    end

    def ratio(currency_from, currency_to)
      round(rate(currency_from) / rate(currency_to))
    end

    def convert(amount, currency_from, currency_to)
      return amount if currency_from == currency_to

      (amount * ratio(currency_from, currency_to))
    end

    def convert_s(amount, currency_from, currency_to)
      convert(amount, currency_from, currency_to).to_digits
    end

    def convert_multi(amount, currency_from, currencies_to)
      currencies_to.map do |currency_to|
        convert(amount, currency_from, currency_to)
      end
    end

    def convert_multi_s(amount, currency_from, currencies_to)
      currencies_to.map do |currency_to|
        convert_s(amount, currency_from, currency_to)
      end
    end

    private

    def round(value)
      BigDecimal.save_rounding_mode do
        BigDecimal.mode(BigDecimal::ROUND_MODE, :half_up)
        value.round(@accuracy)
      end
    end

    def load_provider(name)
      klass = Object.const_get(
        "CurrencyConverter::Providers::#{name.capitalize}Provider"
      )
      klass.new
    end
  end
end
