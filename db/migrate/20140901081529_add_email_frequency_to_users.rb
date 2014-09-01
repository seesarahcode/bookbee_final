class AddEmailFrequencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_frequency, :string, :default => :individual
  end
end
