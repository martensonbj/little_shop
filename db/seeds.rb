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
      puts "Created Category: #{name}"
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

      Artist.create!(first_name: first_name, last_name: last_name)
      puts "Created Artist: #{full_name}"
    end

    @brenna = Artist.find_by(first_name: "Brenna")
    @taylor = Artist.find_by(first_name: "Taylor")
    @toni = Artist.find_by(first_name: "Toni")
  end

  def create_items
    Item.create!(title: "Paris",
                 description: "Oil painting of Paris and the Eiffel Tower",
                 price: 200,
                 image_path: "http://paintingandframe.com/uploadpic/brent_heighton/big/april_in_paris.jpg",
                 artist_id: @brenna.id,
                 category_id: @painting.id)
    Item.create!(title: "German Castle",
                 description: "Photograph of an awe inspiring German castle",
                 price: 100,
                 image_path: "http://hotpenguin.net/wp-content/uploads/2013/10/Neuschwanstein-Germany-photography-by-wohli-45-Awe-Inspiring-Landmarks-Around-The-World.jpeg",
                 artist_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Shanghai Landscape",
                 description: "Photograph of the TV Tower in Shanghai",
                 price: 80,
                 image_path: "http://d1xejl9xcsndu9.cloudfront.net/wp-content/uploads/2013/09/Shanghai-think-636x431.jpg",
                 artist_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Aurora Borealis",
                 description: "Photograph of the Aurora Borealis in winter",
                 price: 150,
                 image_path: "http://i.space.com/images/i/000/034/748/i02/2_Northern_Lights_Milky_Way_at_Pemaquid.jpg?1385159454",
                 artist_id: @brenna.id,
                 category_id: @photography.id)
    Item.create!(title: "Sailboat in Fall",
                 description: "Acrylic painting of a colorful sailboat",
                 price: 200,
                 image_path: "https://dsarasais.files.wordpress.com/2013/11/victorfigol21.jpg",
                 artist_id: @toni.id,
                 category_id: @painting.id)
    Item.create!(title: "Colorful Trees",
                 description: "Digital image of amazing colorful trees that fill you with whimsy",
                 price: 60,
                 image_path: "https://img0.etsystatic.com/013/0/5265257/il_fullxfull.452732472_p61u.jpg",
                 artist_id: @toni.id,
                 category_id: @digital.id)
    Item.create!(title: "Flower Girl",
                 description: "Digital art of a woman with a flowering face",
                 price: 150,
                 image_path: "http://ego-alterego.com/wp-content/uploads/2014/02/Anna-Dittmann-digital-art5.jpg",
                 artist_id: @toni.id,
                 category_id: @digital.id)
    Item.create!(title: "Darkness",
                 description: "Painting of the dark knight, brooding over evil",
                 price: 300,
                 image_path: "http://www.softpainting.com/wp-content/uploads/2015/12/Batman-Painting-8.jpg",
                 artist_id: @taylor.id,
                 category_id: @painting.id)
    Item.create!(title: "Aspens in the Fall",
                 description: "Amazing photograph of aspens in the Colorado Rockies",
                 price: 100,
                 image_path: "http://ridgwaycolorado.com/wp-content/uploads/2013/05/mt-sneffels-aspens.jpg",
                 artist_id: @taylor.id,
                 category_id: @photography.id)
    Item.create!(title: "The Batman Watches",
                 description: "Digital image of Batman watching over the city of Gotham",
                 price: 125,
                 image_path: "http://ninjacrunch.com/wp-content/uploads/2012/3/3/5.jpg",
                 artist_id: @taylor.id,
                 category_id: @digital.id)
    Item.create!(title: "Cheers!",
                 description: "Digital image of delicious cold beer",
                 price: 30,
                 image_path: "http://cdn.superbwallpapers.com/wallpapers/digital-art/spilled-beer-20610-1920x1200.jpg",
                 artist_id: @taylor.id,
                 category_id: @digital.id)
    puts "Created #{Item.count} items"
  end
end

Seed.start
