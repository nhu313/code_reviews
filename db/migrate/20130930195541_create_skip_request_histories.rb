class CreateSkipRequestHistories < ActiveRecord::Migration
  def change
    create_table :skip_request_histories do |t|
      t.integer :user_id
      t.integer :review_request_id

      t.timestamps
    end
  end
end
