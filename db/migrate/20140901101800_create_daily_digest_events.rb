class CreateDailyDigestEvents < ActiveRecord::Migration
  def change
  	create_table :dailydigestevents do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :update_type

      t.timestamps
    end
  end
end
