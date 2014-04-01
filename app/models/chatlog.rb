class Chatlog < ActiveRecord::Base
  has_many :chatpost, dependent: :destroy

  validates :chatname, presence: true
  validates :slug, uniqueness: true

  serialize :administrators
  serialize :permitted
  serialize :usershere

  # Generate random hash string to be used as slug
  before_save { self.slug ||= Digest::MD5.hexdigest(rand(999999999).to_s)[0..8] }

  #default_scope -> {order('created_at DESC')}

  # Override default find method to use slug rather than id
  def self.find(slug)
    find_by_slug(slug)
  end

  # Change default param for chatlog from id to slug for security/anonymity
  def to_param
    slug
  end
end