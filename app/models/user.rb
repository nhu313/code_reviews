class User < ActiveRecord::Base
  validates :uid, :presence => true
end
