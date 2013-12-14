class User < ActiveRecord::Base
	has_many :chatpost, dependent: :destroy
  
  before_save { self.email = email.downcase }
	before_create :create_remember_token
	attr_accessor :twitter_id, :facebook, :linkedin, :location

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, :unless => lambda{ |user| user.password.blank? }
  
  # Convert user's name to friently url format
  def slug
    name.downcase.gsub(" ", "-")  
  end
  
  # Change default param for user from id to id-name for friendly urls.
  # When finding in DB, Rails auto calls .to_i on param, which tosses
  # name and doesn't cause any problems in locating user.
  def to_param
    "#{id}-#{slug}"
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
