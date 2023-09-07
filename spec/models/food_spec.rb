require 'rails_helper'

RSpec.describe Food, type: :model do
  let!(:user) { User.create(name: 'John') }
  let!(:food) { Food.new(name: 'Chocolate', measurement_unit: 'Unit', price: 3.0, quantity: 5, user:) }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(food).to be_valid
    end

    it 'must have the name present' do
      food.name = nil
      expect(food).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      food.name = 'x' * 101
      expect(food).to_not be_valid
    end

    it 'must include a measurement unit' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end

    it 'must include a price greater than or equal to 0' do
      food.price = nil
      expect(food).to_not be_valid

      food.price = -1
      expect(food).to_not be_valid
    end

    it 'must include a quantity' do
      food.quantity = nil
      expect(food).to_not be_valid
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
