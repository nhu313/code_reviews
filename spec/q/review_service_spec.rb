require 'spec_helper'
require 'q/review_service'
require 'mocks/q/mock_data'
require 'mocks/q/mock_model'

module Q
  describe ReviewService do
    let(:model){MockModel.new}
    let(:service){ReviewService.new(model, nil, nil)}



  end
end
