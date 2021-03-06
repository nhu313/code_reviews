class User < ActiveRecord::Base
  validates :uid, :presence => true
  has_many  :review_requests
  has_one   :skipped_review_request
end
