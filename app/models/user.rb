class User < ActiveRecord::Base
  validates :uid, :presence => true
  has_many  :review_requests
  has_many  :review_replies, through: :review_requests
  has_one   :skip_request_history
end
