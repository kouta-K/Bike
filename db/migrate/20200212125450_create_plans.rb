class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :place
      t.datetime :datetime
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
