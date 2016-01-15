class Seed
  def self.start
    new.generate
  end

  def generate
    create_categories
    create_artists
    create_items
  end

  def create_categories
    categories = %w(Painting Digital Photography)

    categories.each do |name|
      Category.create!(name: name)
    end

    @painting = Category.find_by(name: categories[0])
    @digital = Category.find_by(name: categories[1])
    @photography = Category.find_by(name: categories[2])
  end

  def create_artists
    artists = ["Brenna Martenson",
               "Taylor Moore",
               "Toni Rib"]

    artists.each do |full_name|
      first_name = full_name.split.first
      last_name = full_name.split.last

      User.create!(first_name: first_name,
                   last_name: last_name,
                   username: "#{first_name}",
                   password: "password",
                   role: 1)
    end

    @brenna = User.find_by(first_name: "Brenna")
    @taylor = User.find_by(first_name: "Taylor")
    @toni = User.find_by(first_name: "Toni")
  end

  def create_items
    Item.create!(title: "Paris",
                 description: "Oil painting of Paris and the Eiffel Tower",
                 price: 200,
                 image_path: "http://tinyurl.com/zs8xlz8",
                 user_id: @brenna.id,
                 category_id: @painting.id)
    Item.create!(title: "German Castle",
                 description: "Photograph of an awe inspiring German castle",
                 price: 100,
                 image_path: "http://tinyurl.com/h7qo2n2",
                 user_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Shanghai Landscape",
                 description: "Photograph of the TV Tower in Shanghai",
                 price: 80,
                 image_path: "http://tinyurl.com/hwkg2a4",
                 user_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Aurora Borealis",
                 description: "Photograph of the Aurora Borealis in winter",
                 price: 150,
                 image_path: "http://tinyurl.com/zccbtyz",
                 user_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Sailboat in Fall",
                 description: "Acrylic painting of a colorful sailboat",
                 price: 200,
                 image_path: "http://tinyurl.com/zo5d93t",
                 user_id: @toni.id,
                 category_id: @painting.id)
    Item.create!(title: "Colorful Trees",
                 description: "Digital image of amazing colorful trees",
                 price: 60,
                 image_path: "http://tinyurl.com/z2457zf",
                 user_id: @toni.id,
                 category_id: @digital.id)
    Item.create!(title: "Flower Girl",
                 description: "Digital art of a woman with a flowering face",
                 price: 150,
                 image_path: "http://tinyurl.com/h9nvajo",
                 user_id: @toni.id,
                 category_id: @digital.id)
    Item.create!(title: "Darkness",
                 description: "Painting of the dark knight",
                 price: 300,
                 image_path: "http://tinyurl.com/gtckjgl",
                 user_id: @taylor.id,
                 category_id: @painting.id)
    Item.create!(title: "Aspens in the Fall",
                 description: "Amazing photograph of aspens",
                 price: 100,
                 image_path: "http://tinyurl.com/jk2t3p3",
                 user_id: @taylor.id,
                 category_id: @photography.id)
    Item.create!(title: "The Batman Watches",
                 description: "Digital image of Batman watching" \
                              " over the city of Gotham",
                 price: 125,
                 image_path: "http://tinyurl.com/h7dtwv4",
                 user_id: @taylor.id,
                 category_id: @digital.id)
    Item.create!(title: "Cheers!",
                 description: "Digital image of delicious cold beer",
                 price: 30,
                 image_path: "http://tinyurl.com/hnfhnt9",
                 user_id: @taylor.id,
                 category_id: @digital.id)
  end
end

Seed.start
