FactoryGirl.define do
  factory :user do
    name 'Guilherme Labrego'
    location 'São Paulo'
    twitter 'glabrego'
    facebook 'glabrego'
    sequence(:email, 'a') { |n| n+"@gemini.com" }
    password 'rubyonrails'
    admin true
  end

  def random_name
    ('a'..'z').to_a.shuffle.join
  end
end
