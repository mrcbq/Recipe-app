require 'rails_helper'

RSpec.describe 'Public Recipes', type: :system do
  describe 'Public recipes page' do
    let!(:user) { User.create(name: 'Nacho', email: 'nachofino98@gmail.com', password: 'nachofino1',
      password_confirmation: 'nachofino1') }
   
    let!(:recipe) {Recipe.create(name: 'Milk recipe', preparation_time: 1, cooking_time: 0.5,
      description: 'Milk recipe description', public: true, user_id: user.id) }

    let!(:food1) { Food.create(name: 'Milk', measurement_unit: 'Liters', price: 20,
      quantity: 1, user_id: user.id) }
     
    let!(:recipe_food) { RecipeFood.create(food_id: food1.id, recipe_id: recipe.id, quantity: 3)}

    before do
      sign_in user
      visit public_recipes_path
    end

    it 'displays the view title' do
      expect(page).to have_css('h1', text: 'Public Recipes')
    end

    it 'displays the public recipes details' do
      expect(page).to have_css('h2', text: 'Milk recipe')
      expect(page).to have_css('h4', text: 'By: Nacho')
      expect(page).to have_content('Total food items: 1')
      expect(page).to have_content('Total price: $60')
      expect(page).to have_link('See Recipe', href: recipe_path(recipe))
    end
  end
end
