require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(name: 'John', name: "John", email: "jhon@jhon.com", password: "111111") }

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
  end

  context 'Associations' do
    it 'should have many recipes' do
      association = described_class.reflect_on_association(:recipes)
      expect(association.macro).to eq(:has_many)
    end

    it 'should have many recipe_foods' do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq(:has_many)
    end
  end
end
