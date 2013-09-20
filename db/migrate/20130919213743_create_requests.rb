class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :url
      t.date :date_posted
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
