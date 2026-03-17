FactoryBot.define do
  factory :recipe do
    name { 'Salmon temaki hand roll' }
    kitchen
    preference
    food_type
    servings { 4 }
    cook_time { 45 }
    difficulty { 'Medium' }
    ingredients { 'Salmon, sushi rice, nori, scallions, and cucumber.' }
    steps { 'Season the rice, prepare the filling, and roll each hand roll just before serving.' }
    user
  end
end
