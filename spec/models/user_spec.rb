require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(name: 'John') }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'must have the name present' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      user.name = 'x' * 101
      expect(user).to_not be_valid
    end

    it 'must include a preparation_time' do
      user.preparation_time = nil
      expect(user).to_not be_valid
    end

    it 'must include a cooking_time' do
      user.cooking_time = nil
      expect(user).to_not be_valid
    end

    it 'must include a description' do
      user.description = nil
      expect(user).to_not be_valid
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
