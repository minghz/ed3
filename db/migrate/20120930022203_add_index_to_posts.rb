class AddIndexToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.references :user
    end
    add_index :posts, :user_id    
  end
end
