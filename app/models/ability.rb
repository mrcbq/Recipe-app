class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user&.admin?
      can :manage, :all
    else
      can %i[read create], [Food, Recipe]
      can :read, RecipeFood
      can :create, RecipeFood
      can %i[edit destroy update], RecipeFood do |recipe_food|
        recipe_food.recipe.user == user
      end
      can :destroy, Food, user_id: user.id
      can %i[update destroy], Recipe, user_id: user.id
      can :read, Recipe, public: true
      can :public_recipes, Recipe
      can :general_shopping_list, Food
    end
  end
end
