module RecipesHelper
  def calculate_total_price(recipe_foods)
    total_price = 0

    recipe_foods.includes([:food]).each do |recipe_food|
      food = recipe_food.food
      food_price = food.price
      subtotal_price = food_price * recipe_food.quantity
      total_price += subtotal_price
    end

    total_price
  end
end
