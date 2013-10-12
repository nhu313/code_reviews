class CreateSkippedReviewRequests < ActiveRecord::Migration
  def change
    create_table :skipped_review_requests do |t|
      t.integer :user_id
      t.datetime :last_skipped_date

      t.timestamps
    end
  end
end
