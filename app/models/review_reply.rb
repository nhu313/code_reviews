class ReviewReply < ActiveRecord::Base
  belongs_to :review_request

  def title
    review_request.title
  end

  def reviewer
    user
  end
end
