FactoryBot.define do
  factory :user do
    sequence(:phone_number) { |n| "30384#{n.to_s.rjust(5, "0")}" }

    factory :full_user do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      nickname { Faker::Superhero.name }
      otp_secret_key { User.otp_random_secret }
    end
  end
end
