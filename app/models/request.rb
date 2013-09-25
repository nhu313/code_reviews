class Request < ActiveRecord::Base
  validates :title, :url, :presence => true
  has_one :review
  belongs_to :user
end
