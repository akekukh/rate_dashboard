# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RateService, type: :service do
  describe '#find_rate' do
    it 'return rate from cbr' do
      stub_request(:get, /.*cbr.ru.*/)
        .to_return(status: 200, body: fetch_content('cbr_response.xml'), headers: {})

      expect(described_class.find_rate.to_s).to eq('78.0443')
    end

    it 'return rate from database' do
      rate = create(:rate)

      expect(described_class.find_rate.to_s).to eq(rate.rate.to_s)
    end
  end

  def fetch_content(file_name)
    File.read("spec/fixtures/currency_converter/#{file_name}")
  end
end
