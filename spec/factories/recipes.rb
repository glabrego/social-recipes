FactoryGirl.define do
  factory :recipe do
    name "Temaki de Salmão Completo"
    kitchen
    preference
    food_type
    servings 4
    cook_time 45
    difficulty "Médio"
    ingredients "Salmão, Alga, Cream Cheese, Cebolinha e etc."
    steps '1- Cortar alga na metade;'
    user
  end
end
