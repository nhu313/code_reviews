class CreateReviewRequests < ActiveRecord::Migration
  def change
    create_table :review_requests do |t|
      t.string :title
      t.string :url
      t.datetime :posted_date
      t.text :description
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
  end
end
