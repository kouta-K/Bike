class AddReplyIdToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :reply_id, :integer
  end
end
