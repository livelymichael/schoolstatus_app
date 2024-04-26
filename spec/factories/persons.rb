FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    address { "123 Main St, MS, 90210" }
  end
end
