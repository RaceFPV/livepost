class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name, uniqueness: true
end

