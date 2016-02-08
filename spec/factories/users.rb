FactoryGirl.define do
  factory :user do
    email 'admin@gmail.com'
    password 'rubyonrails'
    admin true
  end
end
