class AddLastAvgRatingToBooks < ActiveRecord::Migration
  def change
    add_column :books, :last_avg_rating, :string
  end
end
