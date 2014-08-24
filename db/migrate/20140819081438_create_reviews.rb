class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :text
      t.string :fave_quote

      t.timestamps
    end
  end
end
