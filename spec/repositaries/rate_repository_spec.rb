# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RateRepository, type: :respository do
  describe '#find_active' do
    it 'returns AR object' do
      create(:rate)
      result = repository.find_active

      expect(result).to be_a(Admin::Rate)
    end

    it 'returns nil if data is absent' do
      stub_request(:get, /.*cbr.ru.*/)
        .to_return(status: 200, body: File.read('spec/fixtures/currency_converter/cbr_response.xml'), headers: {})
      create(:rate, finished_at: DateTime.now - 1.day)
      expect(repository.find_active).to be_nil
    end
  end

  def repository
    return @repository if @repository

    @repository = described_class.new(data_source: data_source)
  end

  def data_source
    return @data_source if @data_source

    @data_source = Admin::Rate
  end
end
