class AddCreatedByToChatlogs < ActiveRecord::Migration
  def change
    add_column :chatlogs, :created_by, :string
  end
end
