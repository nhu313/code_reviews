require 'mocks/q/mock_model'

module Q
  Models = {:review_request => MockModel.new,
            :review_reply => MockModel.new,
            :skipped_review_request => MockModel.new,
            :user => MockModel.new}
end
