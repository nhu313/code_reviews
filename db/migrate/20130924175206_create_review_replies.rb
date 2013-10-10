class CreateReviewReplies < ActiveRecord::Migration
  def change
    create_table :review_replies do |t|
      t.string :url
      t.text :comment
      t.datetime :posted_date
      t.datetime :taken_date
      t.integer :reviewer_id
      t.integer :review_request_id

      t.timestamps
    end
  end
end
