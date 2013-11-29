class CreateChatposts < ActiveRecord::Migration
  def change
    create_table :chatposts do |t|
      t.text :post
      t.timestamps
    end
  end
end
