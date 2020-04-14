class AddContentToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :content, :string
  end
end
