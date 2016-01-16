class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, presence: true
  validates :image_path, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :price, presence: true
  validates :description, presence: true

  before_save :check_user_type

  enum status: %w(inactive active)

  private

  def check_user_type
    User.find(user_id).artist?
  end
end
