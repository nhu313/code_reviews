class ReviewRequest < ActiveRecord::Base
  has_one :review_reply
  belongs_to :user
  default_scope {order('posted_date ASC')}

  def completed?
    review_reply && review_reply.posted_date
  end

  def taken?
    review_reply
  end
end
