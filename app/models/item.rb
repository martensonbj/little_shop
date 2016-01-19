class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, presence: true,
                    uniqueness: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :price, presence: true,
                    numericality: { greater_than: 0 }
  validates :description, presence: true

  before_save :check_user_type
  before_save :check_image_path

  scope :active, -> { where(status: 1) }

  enum status: %w(inactive active)

  private

  def check_user_type
    User.find(user_id).artist?
  end

  def check_image_path
    photo_not_available = "https://www.weefmgrenada.com/images/na4.jpg"
    self.image_path = photo_not_available if image_path.nil? || image_path.empty?
  end
end
