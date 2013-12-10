class CreateChatposts < ActiveRecord::Migration
  def change
    create_table :chatposts do |t|
      t.text :post
      t.text :username
      t.integer :chatlog_id
      t.timestamps
    end
  end
end
