FactoryGirl.define do
  factory :user do |user|
    user.first_name "first_name"
    user.last_name "last_name"
    user.email "email@email.com"
    user.uid "uid"
  end
end
