# frozen_string_literal: true

module CurrencyConverter
  module Providers
    class StaticProvider < Middleware
      attr_writer :rates

      def call
        @rates || {}
      end
    end
  end
end
