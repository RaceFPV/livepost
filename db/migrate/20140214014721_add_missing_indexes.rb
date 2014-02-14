    class AddMissingIndexes < ActiveRecord::Migration
      def change
        add_index :chatposts, :chatlog_id
      end
    end