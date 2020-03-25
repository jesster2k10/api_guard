FactoryBot.define do
  factory :whitelisted_token do
    jti "MyString"
    user nil
    exp "2020-03-25 12:18:58"
  end
end
