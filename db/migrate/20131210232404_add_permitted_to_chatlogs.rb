class AddPermittedToChatlogs < ActiveRecord::Migration
  def change
    add_column :chatlogs, :permitted, :text
  end
end
