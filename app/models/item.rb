class Item < ActiveRecord::Base
  belongs_to :artist
  belongs_to :category
  validates :title, presence: true
  validates :image_path, presence: true
  validates :artist_id, presence: true
  validates :category_id, presence: true
  validates :price, presence: true
  validates :description, presence: true
end
