class AddIndexToComments < ActiveRecord::Migration
  def change
    change_table :comments do |c|
      c.references :user
    end
    add_index :comments, :user_id
  end
end
