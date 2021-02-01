require 'faker'

FactoryBot.define do
  factory :person do
    name { Faker::Name.first_name }
    gender  { Faker::Gender.binary }
    initialize_with { new(name, gender) }
  end

  factory :man do
    name { Faker::Name.first_name }
    initialize_with { new(name) }
  end

  factory :woman do
    name { Faker::Name.first_name }
    initialize_with { new(name) }
  end
end