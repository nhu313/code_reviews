class User < ActiveRecord::Base
  validates :uid, :presence => true
  has_many :requests
  has_many :reviews
end
