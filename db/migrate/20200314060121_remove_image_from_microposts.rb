class RemoveImageFromMicroposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :microposts, :image, :string
  end
end
