class CreateOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :opinions do |t|
      t.integer :rate
      t.string  :description
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end
end
