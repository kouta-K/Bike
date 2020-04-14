class AddInvitedToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :invited, :boolean,default: false
  end
end
