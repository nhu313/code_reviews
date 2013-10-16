require 'mocks/q/mock_model'

module Q
  Models =
      # set default and add models
      {:review_request => MockModel.new,
        :review_reply => MockModel.new,
        :skipped_review_request => MockModel.new,
        :user => MockModel.new}
end
