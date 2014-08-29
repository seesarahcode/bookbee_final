class CreateBlockedUsers < ActiveRecord::Migration
  def change
    create_table :blocked_users do |t|
      t.integer :user_id
      t.datetime :date_blocked

      t.timestamps
    end
  end
end
