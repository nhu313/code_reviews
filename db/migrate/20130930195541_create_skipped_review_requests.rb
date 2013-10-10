class CreateSkippedReviewRequests < ActiveRecord::Migration
  def change
    create_table :skipped_review_requests do |t|
      t.integer :user_id
      t.integer :review_request_id

      t.timestamps
    end
  end
end
