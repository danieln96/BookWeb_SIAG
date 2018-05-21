class ChangeOpinions < ActiveRecord::Migration[5.2]
  def change
    change_column :opinions, :description, :text
  end
end
