FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "dsggh88w_!6" }
    password_confirmation { "dsggh88w_!6" }
  end
end