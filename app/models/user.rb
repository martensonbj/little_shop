class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true,
                       uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email_address, presence: true,
                            uniqueness: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  has_many :orders
  has_many :items

  scope :artists, -> { where(role: 1) }

  enum role: %w(default artist admin)

  def full_name
    "#{first_name} #{last_name}"
  end
end
