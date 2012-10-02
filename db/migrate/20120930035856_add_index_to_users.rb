class AddIndexToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :post
    end
    add_index :users, :post_id 
  end
end
