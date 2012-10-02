class RmColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :post_id
  end
end
