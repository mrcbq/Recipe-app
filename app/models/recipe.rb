class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true, length: { maximum: 100 }
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0}
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :public, presence: true, inclusion: { in: [true, false] }
end
end
