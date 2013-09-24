require 'spec_helper'
require 'q/review_service'
require 'mocks/q/mock_model'
require 'mocks/q/mock_data'

module Q
  describe ReviewService do
    let(:model){MockModel.new}
    let(:service){ReviewService.new(model)}

  end
end
