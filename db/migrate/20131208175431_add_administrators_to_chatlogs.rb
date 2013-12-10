class AddAdministratorsToChatlogs < ActiveRecord::Migration
  def change
    add_column :chatlogs, :administrators, :text
  end
end
