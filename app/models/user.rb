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
  validates(:password_digest,  presence:true,
                        length: { minimum:6 }
           )
 # TODO: Add local check for password presence and password confirmation.
           # In actuality, only password_digest is saved in the database
 # validates(:password,  presence:true,
 #                       length: { minimum:6 }
 #          )

  #validates(:password_confirmation, presence:true)

  has_many :posts, :dependent => :destroy
  #has_many :comments, :dependent => :destroy
  has_many :comments, :dependent => :destroy, :as => :commentable

  accepts_nested_attributes_for :posts#, :allow_destroy => :true#,
  #    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  #end
  accepts_nested_attributes_for :comments

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    email = UserMailer.password_reset(self).deliver

#    assert !ActionMailer::Base.deliveries.empty?
#
#    assert_equal [user.email], email.to
#    assert_equal 'Ed3 Password Reset', email.subject
    logger.debug email.body.to_s   
  
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
