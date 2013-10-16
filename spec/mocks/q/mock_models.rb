require 'mocks/q/mock_model'

module Q
  class MockModels
    def self.map
      Hash.new(MockModel.new)
      # set default and add models
      # {:review_request => MockModel.new,
      #   :review_reply => MockModel.new,
      #   :skipped_review_request => MockModel.new,
      #   :user => MockModel.new
      # }
    end
  end
end
