# frozen_string_literal: true

module CurrencyConverter
  module Providers
    class StaticProvider < Middleware
      attr_writer :rates

      def call
        DEFAULT_RUB_RATE.merge({ USD: RateRepository.new.find_active.rate.to_s })
      end
    end
  end
end
