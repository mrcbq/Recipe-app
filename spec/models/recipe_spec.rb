require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:user) { User.create(name: 'John') }
  let!(:recipe) do
    Recipe.new(name: 'Chocolate', preparation_time: '2', cooking_time: '3', description: 'A delicious beverage',
               public: true, user:)
  end

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(recipe).to be_valid
    end

    it 'must have the name present' do
      recipe.name = nil
      expect(recipe).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      recipe.name = 'x' * 101
      expect(recipe).to_not be_valid
    end

    it 'must include a preparation_time' do
      recipe.preparation_time = nil
      expect(recipe).to_not be_valid
    end

    it 'must include a cooking_time' do
      recipe.cooking_time = nil
      expect(recipe).to_not be_valid
    end

    it 'must include a description' do
      recipe.description = nil
      expect(recipe).to_not be_valid
    end
  end

  context 'Associations' do
    it 'should belong to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'should have many recipe_foods' do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end
