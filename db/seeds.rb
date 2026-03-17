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

japanese = seed_taxonomy!(Kitchen, :name, 'Japonesa')
brazilian = seed_taxonomy!(Kitchen, :name, 'Brasileira')
italian = seed_taxonomy!(Kitchen, :name, 'Italiana')
mediterranean = seed_taxonomy!(Kitchen, :name, 'Mediterranea')

savory = seed_taxonomy!(FoodType, :name, 'Salgado')
dessert = seed_taxonomy!(FoodType, :name, 'Sobremesa')

lactose_free = seed_taxonomy!(Preference, :title, 'Sem lactose')
vegetarian = seed_taxonomy!(Preference, :title, 'Vegetariana')
gluten_free = seed_taxonomy!(Preference, :title, 'Sem gluten')

seed_recipe!(
  name: 'Temaki de Salmao Completo',
  kitchen: japanese,
  food_type: savory,
  preference: lactose_free,
  user: admin,
  servings: 4,
  cook_time: 45,
  difficulty: 'Médio',
  ingredients: <<~TEXT.strip,
    Arroz para sushi, salmao fresco, alga nori, cebolinha, pepino e gergelim.
  TEXT
  steps: <<~TEXT.strip,
    Tempere o arroz, corte o salmao em tiras, organize os recheios e monte cada cone de nori na hora de servir.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=1400&q=80',
    filename: 'temaki-de-salmao.jpg',
    photographer: 'Mgg Vitchakorn',
    profile_url: 'https://unsplash.com/@mggbox'
  }
)

seed_recipe!(
  name: 'Lasanha de Berinjela Assada',
  kitchen: italian,
  food_type: savory,
  preference: vegetarian,
  user: marina,
  servings: 6,
  cook_time: 70,
  difficulty: 'Médio',
  ingredients: <<~TEXT.strip,
    Berinjela, molho de tomate, muzzarella vegetal, manjericao, alho e azeite.
  TEXT
  steps: <<~TEXT.strip,
    Grelhe as fatias de berinjela, monte camadas com molho e recheio, cubra com manjericao e asse ate borbulhar.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1619895092538-128341789043?auto=format&fit=crop&w=1400&q=80',
    filename: 'lasanha-de-berinjela.jpg',
    photographer: 'Monika Grabkowska',
    profile_url: 'https://unsplash.com/@moniqa'
  }
)

seed_recipe!(
  name: 'Moqueca de Banana da Terra',
  kitchen: brazilian,
  food_type: savory,
  preference: gluten_free,
  user: marina,
  servings: 4,
  cook_time: 35,
  difficulty: 'Fácil',
  ingredients: <<~TEXT.strip,
    Banana da terra, pimentao, tomate, cebola roxa, leite de coco, coentro e azeite de dendê.
  TEXT
  steps: <<~TEXT.strip,
    Refogue os legumes, acomode as rodelas de banana, junte leite de coco e dendê e cozinhe ate tudo ficar macio.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?auto=format&fit=crop&w=1400&q=80',
    filename: 'moqueca-de-banana.jpg',
    photographer: 'Mae Mu',
    profile_url: 'https://unsplash.com/@mae_mu'
  }
)

seed_recipe!(
  name: 'Rigatoni ao Pomodoro Lento',
  kitchen: italian,
  food_type: savory,
  preference: lactose_free,
  user: leo,
  servings: 4,
  cook_time: 40,
  difficulty: 'Fácil',
  ingredients: <<~TEXT.strip,
    Rigatoni, tomate pelado, alho, cebola, azeite, pimenta calabresa e manjericao fresco.
  TEXT
  steps: <<~TEXT.strip,
    Cozinhe o molho lentamente com alho e cebola, junte a massa al dente e finalize com bastante manjericao.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=1400&q=80',
    filename: 'rigatoni-pomodoro.jpg',
    photographer: 'Jakub Kapusnak',
    profile_url: 'https://unsplash.com/@foodiesfeed'
  }
)

seed_recipe!(
  name: 'Salada Crocante de Graos e Ervas',
  kitchen: mediterranean,
  food_type: savory,
  preference: vegetarian,
  user: leo,
  servings: 3,
  cook_time: 20,
  difficulty: 'Fácil',
  ingredients: <<~TEXT.strip,
    Grao-de-bico, pepino, rabanete, hortela, salsa, limao, azeite e sementes tostadas.
  TEXT
  steps: <<~TEXT.strip,
    Misture os vegetais bem gelados com os graos, tempere com limao e azeite e finalize com ervas e sementes.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1400&q=80',
    filename: 'salada-de-graos.jpg',
    photographer: 'Eiliv Aceron',
    profile_url: 'https://unsplash.com/@eiliv'
  }
)

seed_recipe!(
  name: 'Panquecas Douradas com Frutas',
  kitchen: brazilian,
  food_type: dessert,
  preference: vegetarian,
  user: admin,
  servings: 4,
  cook_time: 25,
  difficulty: 'Fácil',
  ingredients: <<~TEXT.strip,
    Farinha, ovos, leite vegetal, fermento, melado, morangos e banana.
  TEXT
  steps: <<~TEXT.strip,
    Prepare a massa, doure pequenas porcoes na frigideira e sirva com frutas frescas e melado por cima.
  TEXT
  image: {
    url: 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?auto=format&fit=crop&w=1400&q=80',
    filename: 'panquecas-com-frutas.jpg',
    photographer: 'Joseph Gonzalez',
    profile_url: 'https://unsplash.com/@miracletwentyone'
  }
)
