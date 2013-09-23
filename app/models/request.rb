class Request < ActiveRecord::Base
  validates :title, :url, :presence => true
end
