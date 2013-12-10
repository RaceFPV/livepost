class AddPrivatechatToChatlog < ActiveRecord::Migration
  def change
    add_column :chatlogs, :privatechat, :boolean
  end
end
