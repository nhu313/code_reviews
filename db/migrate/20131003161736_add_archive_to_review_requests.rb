class AddArchiveToReviewRequests < ActiveRecord::Migration
  def change
    add_column :review_requests, :archive, :boolean, default: false
  end
end
