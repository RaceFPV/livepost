class AddSuperUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_user, :boolean
  end
end
