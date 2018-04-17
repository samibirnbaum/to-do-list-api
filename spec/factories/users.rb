#beware of validations in the model
FactoryBot.define do
  factory :user do
    username "SamiB"
    password "password"
    email "sami@sami.com"
  end
end
