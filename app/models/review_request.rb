class ReviewRequest < ActiveRecord::Base
  has_one :review_reply
  belongs_to :user
  belongs_to :user, foreign_key: :reviewer_id

  default_scope {order('posted_date ASC')}

  def completed?
    review_reply
  end

  def taken?
    reviewer_id
  end

  def reviewer_name
    user.first_name + ' ' + user.last_name
  end
end
