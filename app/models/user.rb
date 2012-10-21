class User < ActiveRecord::Base
  attr_accessible(:email, :name, :posts_attributes, :comments_attributes, :password, :password_confirmation)
  has_secure_password

  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates(:name,  presence: true, 
                    length: { maximum: 50 }
           )
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true,
                    format: {with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
           )
  validates(:password,  presence:true,
                        length: { minimum:6 }
           )
  validates(:password_confirmation, presence:true)

  has_many :posts, :dependent => :destroy
  #has_many :comments, :dependent => :destroy
  has_many :comments, :dependent => :destroy, :as => :commentable

  accepts_nested_attributes_for :posts#, :allow_destroy => :true#,
  #    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  #end
  accepts_nested_attributes_for :comments

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
