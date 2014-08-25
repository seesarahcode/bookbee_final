class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.string :title
      t.boolean :ratings, default: true
      t.boolean :reviews, default: true
      t.integer :book_id

      t.timestamps
    end
  end
end
