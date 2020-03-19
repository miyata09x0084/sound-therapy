FactoryBot.define do
  factory :add do
    url {Faker::Internet.url}
    artist {Faker::Name.name}
    song {Faker::Music.album}
  end
end