class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter

  validates :body, :presence => true

  #belongs_to :post
  #belongs_to :user
  
  belongs_to :commentable, :polymorphic => true

end
