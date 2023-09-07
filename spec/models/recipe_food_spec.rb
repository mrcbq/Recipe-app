require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let!(:user) { User.create(name: 'Nacho') }
  let!(:food) { Food.create(name: 'Milk', measurement_unit: 'Litter', price: 3.0, quantity: 5) }
  let!(:recipe) { Recipe.create(name: 'Cake', preparation_time: 50, cooking_time: 30, description: 'Cake',
    user_id: user.id, public: true) }
  let!(:recipe_food) { RecipeFood.new(food:, recipe:, quantity: 3) }

  context 'Validation' do
    it 'should be valid with valid atributes' do
      expect(recipe_food).to be_valid
    end

    it 'must include a quantity' do
      recipe_food.quantity = nil
      expect(recipe_food).to_not be_valid
    end
  end

  context 'Associations' do
    it 'must belong to a food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'must belong to a recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
