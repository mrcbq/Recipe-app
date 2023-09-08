class Recipe < ApplicationRecord
  before_destroy :delete_associated_recipe_foods

  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :public, inclusion: { in: [true, false] }

  def delete_associated_recipe_foods
    recipe_foods.destroy_all
  end
end
