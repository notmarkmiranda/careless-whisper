FactoryBot.define do
  factory :user do
    phone_number { Phonelib.parse(Faker::PhoneNumber.phone_number).national_number }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Superhero.name }
    otp_secret_key { User.otp_random_secret }
  end
end
