class AddReceiveBookUpdatesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_book_updates, :boolean, default: true
  end
end
