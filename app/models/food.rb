class Food < ApplicationRecord
  before_destroy :delete_associated_recipe_foods

  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def delete_associated_recipe_foods
    recipe_foods.destroy_all
  end
end
