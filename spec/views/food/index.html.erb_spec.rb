require 'rails_helper'

RSpec.describe 'food/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'nacho', email: 'nachofino98@gmail.com', password: 'nachofino1', password_confirmation: 'nachofino1')
    end

    let!(:food1) do
      Food.create(user_id: user.id, name: 'Chocolate', measurement_unit: 'units', price: 20, quantity: 3)
    end

    let!(:food2) do
      Food.create(user_id: user.id, name: 'Milk', measurement_unit: 'Liters', price: 10, quantity: 10)
    end

    before do
      sign_in user
      visit foods_path
    end

    it 'displays a list of foods' do
      expect(page).to have_content('Foods')

      expect(page).to have_content(food1.name)
      expect(page).to have_content(food2.name)
      expect(page).to have_content(food1.quantity)
      expect(page).to have_content(food2.quantity)
    end

    it 'Display button remove' do
      expect(page).to have_button('Delete')
    end

    it 'Check correct url' do
      expect(page).to have_link('New food', href: new_food_path)
    end
  end
end
