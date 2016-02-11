class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_and_belongs_to_many :favorites, class_name: :Recipe, join_table: :recipes_users
  has_and_belongs_to_many :likes, class_name: :kitchen, join_table: :kitchens_users
end
