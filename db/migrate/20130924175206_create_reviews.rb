class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :url
      t.text :comment
      t.date :posted_date
      t.interger :reviewer_id

      t.timestamps
    end
  end
end
