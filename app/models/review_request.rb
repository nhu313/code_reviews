class ReviewRequest < ActiveRecord::Base
  validates :title, :url, :presence => true
  has_one :review_reply
  belongs_to :user
end
