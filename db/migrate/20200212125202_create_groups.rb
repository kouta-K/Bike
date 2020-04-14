class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :introduce

      t.timestamps
    end
  end
end
