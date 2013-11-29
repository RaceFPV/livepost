class CreateChatlogs < ActiveRecord::Migration
  def change
    create_table :chatlogs do |t|
      t.text :chathistory
      t.text :username
      t.timestamps
    end
  end
end
