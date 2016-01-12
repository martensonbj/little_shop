FactoryGirl.define do
  factory :artist do
    first_name
    last_name
    factory :items_with_artist do
      transient do
        item_count 2
      end
      after(:create) do |artist, evaluator|
        create_list(:item, evaluator.item_count, artist: artist)
      end
    end
  end

  factory :item do
    title
    image_path "https://s-media-cache-ak0.pinimg.com/236x/ac/79/ec/ac79ecfd60f82e28cabdfb8f1dc10df4.jpg"
    category "portrait"
    artist_id
  end

  sequence :first_name do |n|
    "firstname#{n}"
  end

  sequence :last_name do |n|
    "lastname#{n}"
  end

  sequence :title do |n|
    "title#{n}"
  end

  sequence :artist_id do |n|
    n
  end
end
