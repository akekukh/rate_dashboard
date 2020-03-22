class RateController < ApplicationController
  def index
    @rate = RateService.find_rate
  end
end
