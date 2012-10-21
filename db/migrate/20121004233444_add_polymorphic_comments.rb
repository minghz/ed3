class AddPolymorphicComments < ActiveRecord::Migration
  def up
    change_table :comments do |c|
      c.references :commentable, :polymorphic => true
    end

  end
end
