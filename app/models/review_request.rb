class ReviewRequest < ActiveRecord::Base
  validates :title, :url, :presence => true
  has_one :review_reply
  belongs_to :user

  def completed?
    review_reply && review_reply.posted_date
  end

  def taken?
    review_reply
  end
end
