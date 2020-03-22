# frozen_string_literal: true

require 'rexml/document'

module CurrencyConverter
  module Providers
    class CbrProvider < Middleware
      SERVICE_URI = 'http://www.cbr.ru/scripts/xml_daily.asp'
      DEFAULT_RUB_RATE = { RUB: '1' }.freeze

      def call
        parse_response(request)
      end

      private

      def parse_response(data)
        doc = REXML::Document.new(data)
        rates = {}
        raise(ArgumentError, I18n.t('currency_converter.empty')) if doc.root.blank?

        doc.elements.each('ValCurs/Valute') do |valute|
          code = REXML::XPath.first(valute, 'CharCode/text()').to_s
          val = REXML::XPath.first(valute, 'Value/text()').to_s
          rates[code.upcase.to_sym] = val
        end
        DEFAULT_RUB_RATE.merge(rates)
      end

      def request
        uri = URI(SERVICE_URI)
        Faraday.get(uri).body
      end
    end
  end
end
