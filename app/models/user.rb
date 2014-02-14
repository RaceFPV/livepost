class User < ActiveRecord::Base
	has_many :chatpost, dependent: :destroy
  before_save { self.email = email.downcase }
	before_create :create_remember_token
  validates :name, uniqueness: true #make sure each users name is unique
  validates_length_of :name, :minimum => 3, :maximum => 30

  # Convert user's name to friendly url format
  def slug
    name.downcase.gsub(" ", "-")
  end

  # Change default param for user from id to id-name for friendly urls.
  # When finding in DB, Rails auto calls .to_i on param, which tosses
  # name and doesn't cause any problems in locating user.
  def to_param
    "#{id}-#{slug}"
  end

#---------------- for oauth ------------------
def self.from_omniauth(auth)
  where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
end

def self.create_from_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.email = auth["info"]["email"]
    user.image = auth["info"]["image"]
  end
end
#----------------- end of oauth code ---------------

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