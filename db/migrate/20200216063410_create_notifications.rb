class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :visited, foreign_key: { to_table: :users }
      t.references :member, foreign_key: true
      t.string :action
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
