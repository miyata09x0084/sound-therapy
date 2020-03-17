FactoryBot.define do
  factory :playlist do
    name {Faker::Team.name}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    user
  end
end