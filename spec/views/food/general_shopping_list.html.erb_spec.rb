require 'rails_helper'

RSpec.describe 'General Shopping List', type: :system do
  describe 'Shopping List page' do
    let!(:user) do
      User.create(name: 'Nacho', email: 'nachofino98@gmail.com', password: 'nachofino1',
                  password_confirmation: 'nachofino1')
    end

    let!(:food1) do
      Food.create(name: 'Milk', measurement_unit: 'Liters', price: 20,
                  quantity: 1, user_id: user.id)
    end

    let!(:recipe) do
      Recipe.create(name: 'Milk recipe', preparation_time: 1, cooking_time: 0.5,
                    description: 'Milk recipe description', public: true, user_id: user.id)
    end

    let!(:recipe_food) { RecipeFood.create(food_id: food1.id, recipe_id: recipe.id, quantity: 3) }

    before do
      sign_in user
      visit general_shopping_list_path
    end

    it 'displays the view title' do
      expect(page).to have_css('h1', text: 'General Shopping List')
    end

    it 'displays the amount of food items to buy' do
      expect(page).to have_content('Amount of food items to buy: 1')
    end

    it 'displays the total value of food needed' do
      expect(page).to have_content('Total value of food needed: 40.0')
    end

    it 'displays the name and quantity of the items to buy' do
      expect(page).to have_content('Milk')
      expect(page).to have_content('2.0 Liters')
      expect(page).to have_content('$ 40.0')
    end

    it 'displays the table headers' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end
  end
end
