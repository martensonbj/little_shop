class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                       uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :orders
  has_many :items

  enum role: %w(default artist admin)
end
