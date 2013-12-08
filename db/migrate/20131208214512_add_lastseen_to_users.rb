class AddLastseenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastseen, :datetime
  end
end
