require 'rails_helper'

RSpec.describe 'recipe/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'John', email: 'jhon@jhon.com', password: '111111', password_confirmation: '111111')
    end

    let!(:recipe1) do
      Recipe.create(name: 'Chocolate with bread', preparation_time: '2', cooking_time: '3',
                    description: 'A delicious beverage', public: true, user_id: user.id)
    end

    let!(:recipe2) do
      Recipe.create(name: 'Risotto with meat',
                    preparation_time: '2',
                    cooking_time: '3',
                    description: 'Delicious plate',
                    public: true, user_id: user.id)
    end

    before do
      sign_in user
      visit recipes_path
    end

    it 'displays a list of recipes' do
      expect(page).to have_content(recipe1.name)
      expect(page).to have_content(recipe2.name)
    end

    it 'Display button remove' do
      expect(page).to have_link('New recipe')
    end

    it 'Check correct url' do
      expect(page).to have_link('New recipe', href: new_recipe_path)
    end
  end
end
