require 'open-uri'

def seed_user!(attributes)
  user = User.find_or_initialize_by(email: attributes.fetch(:email))
  user.assign_attributes(attributes)
  user.save!
  user
end

def seed_taxonomy!(model_class, attribute, value)
  model_class.find_or_create_by!(attribute => value)
end

def attach_remote_photo!(record, image)
  return unless Rails.env.development?
  return if record.photo.attached?

  io = URI.open(image.fetch(:url), read_timeout: 15)
  filename = image.fetch(:filename)

  record.photo.attach(
    io: io,
    filename: filename,
    content_type: image.fetch(:content_type, 'image/jpeg'),
    metadata: {
      source: 'unsplash',
      attribution_name: image.fetch(:photographer),
      attribution_url: image.fetch(:profile_url)
    }
  )
rescue StandardError => error
  warn "Skipping photo attachment for #{record.name}: #{error.class} - #{error.message}"
end

def seed_recipe!(attributes)
  image = attributes.delete(:image)
  recipe = Recipe.find_or_initialize_by(name: attributes.fetch(:name))
  recipe.assign_attributes(attributes)
  recipe.save!
  attach_remote_photo!(recipe, image) if image
  recipe
end

admin = seed_user!(
  email: 'admin@socialrecipes.local',
  name: 'Social Recipes Admin',
  location: 'Sao Paulo',
  twitter: 'socialrecipes',
  facebook: 'socialrecipes',
  password: 'rubyonrails',
  password_confirmation: 'rubyonrails',
  admin: true
)

marina = seed_user!(
  email: 'marina@socialrecipes.local',
  name: 'Marina Costa',
  location: 'Rio de Janeiro',
  twitter: 'marinacooks',
  facebook: 'marinacooks',
  password: 'rubyonrails',
  password_confirmation: 'rubyonrails',
  admin: false
)

leo = seed_user!(
  email: 'leo@socialrecipes.local',
  name: 'Leo Araujo',
  location: 'Belo Horizonte',
  twitter: 'leoaraujocooks',
  facebook: 'leoaraujocooks',
  password: 'rubyonrails',
  password_confirmation: 'rubyonrails',
  admin: false
)

japanese = seed_taxonomy!(Kitchen, :name, 'Japanese')
brazilian = seed_taxonomy!(Kitchen, :name, 'Brazilian')
italian = seed_taxonomy!(Kitchen, :name, 'Italian')
mediterranean = seed_taxonomy!(Kitchen, :name, 'Mediterranean')

main_dish = seed_taxonomy!(FoodType, :name, 'Main dish')
dessert = seed_taxonomy!(FoodType, :name, 'Dessert')

lactose_free = seed_taxonomy!(Preference, :title, 'Lactose-free')
vegetarian = seed_taxonomy!(Preference, :title, 'Vegetarian')
gluten_free = seed_taxonomy!(Preference, :title, 'Gluten-free')

seed_recipe!(
  name: 'Salmon temaki hand roll',
  kitchen: japanese,
  food_type: main_dish,
  preference: lactose_free,
  user: admin,
  servings: 4,
  cook_time: 45,
  difficulty: 'Medium',
  ingredients: <<~TEXT.strip,
    Sushi rice, fresh salmon, nori, scallions, cucumber, and toasted sesame.
  TEXT
  steps: <<~TEXT.strip,
    Season the rice, slice the salmon, set out the fillings, and assemble each hand roll just before serving.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=1400&q=80',
    filename: 'salmon-temaki.jpg',
    photographer: 'Mgg Vitchakorn',
    profile_url: 'https://unsplash.com/@mggbox'
  }
)

seed_recipe!(
  name: 'Roasted eggplant lasagna',
  kitchen: italian,
  food_type: main_dish,
  preference: vegetarian,
  user: marina,
  servings: 6,
  cook_time: 70,
  difficulty: 'Medium',
  ingredients: <<~TEXT.strip,
    Eggplant, tomato sauce, mozzarella, basil, garlic, and olive oil.
  TEXT
  steps: <<~TEXT.strip,
    Roast the eggplant slices, layer them with sauce and filling, top with basil, and bake until bubbling.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1619895092538-128341789043?auto=format&fit=crop&w=1400&q=80',
    filename: 'roasted-eggplant-lasagna.jpg',
    photographer: 'Monika Grabkowska',
    profile_url: 'https://unsplash.com/@moniqa'
  }
)

seed_recipe!(
  name: 'Plantain moqueca',
  kitchen: brazilian,
  food_type: main_dish,
  preference: gluten_free,
  user: marina,
  servings: 4,
  cook_time: 35,
  difficulty: 'Easy',
  ingredients: <<~TEXT.strip,
    Plantains, bell pepper, tomato, red onion, coconut milk, cilantro, and palm oil.
  TEXT
  steps: <<~TEXT.strip,
    Saute the vegetables, add the plantain slices, pour in the coconut milk and palm oil, and simmer until tender.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?auto=format&fit=crop&w=1400&q=80',
    filename: 'plantain-moqueca.jpg',
    photographer: 'Mae Mu',
    profile_url: 'https://unsplash.com/@mae_mu'
  }
)

seed_recipe!(
  name: 'Slow-simmered rigatoni pomodoro',
  kitchen: italian,
  food_type: main_dish,
  preference: lactose_free,
  user: leo,
  servings: 4,
  cook_time: 40,
  difficulty: 'Easy',
  ingredients: <<~TEXT.strip,
    Rigatoni, peeled tomatoes, garlic, onion, olive oil, chile flakes, and fresh basil.
  TEXT
  steps: <<~TEXT.strip,
    Simmer the sauce slowly with garlic and onion, add the al dente pasta, and finish with plenty of basil.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=1400&q=80',
    filename: 'rigatoni-pomodoro.jpg',
    photographer: 'Jakub Kapusnak',
    profile_url: 'https://unsplash.com/@foodiesfeed'
  }
)

seed_recipe!(
  name: 'Herbed chickpea crunch salad',
  kitchen: mediterranean,
  food_type: main_dish,
  preference: vegetarian,
  user: leo,
  servings: 3,
  cook_time: 20,
  difficulty: 'Easy',
  ingredients: <<~TEXT.strip,
    Chickpeas, cucumber, radish, mint, parsley, lemon, olive oil, and toasted seeds.
  TEXT
  steps: <<~TEXT.strip,
    Toss the chilled vegetables with the chickpeas, season with lemon and olive oil, and finish with herbs and seeds.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1400&q=80',
    filename: 'herbed-chickpea-salad.jpg',
    photographer: 'Eiliv Aceron',
    profile_url: 'https://unsplash.com/@eiliv'
  }
)

seed_recipe!(
  name: 'Golden fruit pancakes',
  kitchen: brazilian,
  food_type: dessert,
  preference: vegetarian,
  user: admin,
  servings: 4,
  cook_time: 25,
  difficulty: 'Easy',
  ingredients: <<~TEXT.strip,
    Flour, eggs, plant milk, baking powder, molasses, strawberries, and banana.
  TEXT
  steps: <<~TEXT.strip,
    Mix the batter, cook small pancakes until golden, and serve with fresh fruit and molasses.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?auto=format&fit=crop&w=1400&q=80',
    filename: 'golden-fruit-pancakes.jpg',
    photographer: 'Joseph Gonzalez',
    profile_url: 'https://unsplash.com/@miracletwentyone'
  }
)
