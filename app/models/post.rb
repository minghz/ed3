class Post < ActiveRecord::Base
  attr_accessible :content, :title, :tags_attributes

  validates :title, :presence => true,
                    :length => { :maximum => 40 }
  
  validates :content,  :presence => true
  validates :user_id,  :presence => true

  has_many :comments, :dependent => :destroy
  has_many :tags, :dependent => :destroy

  accepts_nested_attributes_for :tags, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }


  belongs_to :user

end
