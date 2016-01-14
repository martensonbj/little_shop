class Artist < ActiveRecord::Base
  has_many :items
  validates :first_name, presence: true
  validates :last_name, presence: true
end
