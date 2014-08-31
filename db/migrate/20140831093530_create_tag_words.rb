class CreateTagWords < ActiveRecord::Migration
  def change
    create_table :tag_words do |t|
      t.integer :book_id
      t.string :word

      t.timestamps
    end
  end
end
