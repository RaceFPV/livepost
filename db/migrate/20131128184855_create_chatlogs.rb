class CreateChatlogs < ActiveRecord::Migration
  def change
    create_table :chatlogs do |t|
      t.text :chatname
      t.timestamps
    end
  end
end
