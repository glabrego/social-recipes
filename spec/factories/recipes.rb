FactoryGirl.define do
  factory :recipe do
    name "MyString"
    kitchen
    preference
    food_type
    servings 4
    cook_time 45
    difficulty "MyString"
    steps "MyString"
    ingredients "MyString"
  end
end
