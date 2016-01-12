class Category < ActiveRecord::Base
  has_many :items
  before_create :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end

end
