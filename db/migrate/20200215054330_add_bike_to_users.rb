class AddBikeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bike, :string
  end
end
