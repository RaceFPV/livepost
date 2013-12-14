class AddUserIdToChatposts < ActiveRecord::Migration
  def change
    add_column :chatposts, :user_id, :integer
    add_index :chatposts, :user_id
    
    rename_column :chatposts, :username, :user_name
  end
end
