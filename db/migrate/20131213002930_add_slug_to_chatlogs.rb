class AddSlugToChatlogs < ActiveRecord::Migration
  def change
    add_column :chatlogs, :slug, :string
    add_index :chatlogs, :slug, unique: true
  end
end
