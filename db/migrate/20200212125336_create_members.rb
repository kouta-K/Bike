class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.boolean :activate

      t.timestamps
    end
  end
end
