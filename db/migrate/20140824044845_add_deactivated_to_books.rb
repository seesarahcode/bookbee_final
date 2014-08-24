class AddDeactivatedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :deactivated, :boolean, default: false
  end
end
