require 'rails_helper'

RSpec.describe 'recipe/show', type: :system do
  describe 'show page' do
    let!(:user) do
      User.create(name: 'John', email: 'jhon@jhon.com', password: '111111', password_confirmation: '111111')
    end

    let!(:recipe1) do
      Recipe.create(name: 'Chocolate with bread', preparation_time: '2', cooking_time: '3',
                    description: 'A delicious beverage', public: true, user_id: user.id)
    end

    let!(:recipe2) do
      Recipe.create(name: 'Risotto with meat', preparation_time: '2', cooking_time: '3', description: 'Delicious plate',
                    public: true, user_id: user.id)
    end

    before do
      sign_in user
      visit recipe_path(recipe1)
    end

    it 'displays a recipe1' do
      expect(page).to have_content(recipe1.name)
      expect(page).to have_content(recipe1.preparation_time)
      expect(page).to have_content(recipe1.cooking_time)
      expect(page).to have_content(recipe1.description)
    end

    it 'Display destroy this recipe button' do
      expect(page).to have_button('Destroy this recipe')
    end

    it 'Check correct url' do
      expect(page).to have_link('Back to recipes', href: recipes_path)
    end
  end
end
