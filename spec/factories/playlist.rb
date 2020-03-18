FactoryBot.define do
  factory :playlist do
    name {Faker::Team.name}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    user
  end
end