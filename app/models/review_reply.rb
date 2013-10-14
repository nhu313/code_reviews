class ReviewReply < ActiveRecord::Base
  belongs_to :review_request
end
