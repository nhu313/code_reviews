class ReviewReply < ActiveRecord::Base
  belongs_to :review_request
  belongs_to :user, foreign_key: :reviewer_id

  def title
    review_request.title
  end
end
