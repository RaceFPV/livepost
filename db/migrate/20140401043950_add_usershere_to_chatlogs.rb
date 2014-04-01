class AddUsershereToChatlogs < ActiveRecord::Migration
  def change
    add_column :chatlogs, :usershere, :text
  end
end
