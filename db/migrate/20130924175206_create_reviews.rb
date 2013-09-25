class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :url
      t.text :comment
      t.date :posted_date
      t.integer :reviewer_id
      t.integer :request_id

      t.timestamps
    end
  end
end
