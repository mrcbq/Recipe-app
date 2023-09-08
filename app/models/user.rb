class User < ApplicationRecord
  before_destroy :delete_associated_recipes_and_foods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes
  has_many :foods

  validates :name, presence: true, length: { maximum: 100 }

  def admin?
    role == 'admin'
  end

  def delete_associated_recipes_and_foods
    recipes.destroy_all
    foods.destroy_all
  end
end
