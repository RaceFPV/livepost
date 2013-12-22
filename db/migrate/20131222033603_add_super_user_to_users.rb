class AddSuperUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_user, :string
  end
end
