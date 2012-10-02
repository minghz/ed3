class RmIndexToUsers < ActiveRecord::Migration
  def change
    remove_index :users, :post_id
  end
end
