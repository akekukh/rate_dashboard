# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrencyConverter::Providers::CbrProvider, type: :request do
  describe '#fetch_rates' do
    it 'return rates if response success' do
      stub_request(:get, /.*cbr.ru.*/)
        .to_return(status: 200, body: fetch_content('cbr_response.xml'), headers: {})

      expect(described_class.new.call).to eq(
        RUB: '1',
        USD: '78,0443'
      )
    end
  end

  def fetch_content(file_name)
    File.read("spec/fixtures/currency_converter/#{file_name}")
  end
end
