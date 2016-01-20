class User < ActiveRecord::Base
  before_create :generate_slug
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

  has_attached_file :file_upload,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://www.weefmgrenada.com/images/na4.jpg"

  validates_attachment_content_type :file_upload,
                                    content_type: %r{\Aimage\/.*\Z}

  scope :artists, -> { where(role: 1) }

  enum role: %w(default artist admin)

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug = username.parameterize
  end
end
