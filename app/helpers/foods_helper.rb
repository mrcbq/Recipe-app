module FoodsHelper

  def calculate_total_items(recipe_foods)
    result = {}

    recipe_foods.each do |recipe_food|
      element = recipe_food.food.name
      quantity = recipe_food.quantity

      if result.key?(element)
        result[element] += quantity
      else
        result[element] = quantity
      end
    end
  result
  end

  def calculate_food_totals(foods)
    result_quantity = {}
    unit_price = {}

    foods.each do |food|
      element = food.name
      quantity = food.quantity
      price = food.price

      if result_quantity.key?(element)
        old_price = unit_price[element]
        old_quantity = result_quantity[element]

        new_price = (old_price * old_quantity + price * quantity)/(quantity + old_quantity)

        result_quantity[element] += quantity
        unit_price[element] = new_price.round(2)
      else
        result_quantity[element] = quantity
        unit_price[element] = price
      end
    end
  [result_quantity, unit_price]
  end

  def calculate_totals_needed(inventory, needs)
    shop = {}
    needs.each do |element, quantity|
      inventory_quantity = inventory[element] || 0
      need_quantity = quantity - inventory_quantity
      shop[element] = need_quantity if need_quantity > 0
    end  
    shop
  end

  def calculate_price(shop, price)
    total = 0
    shop.each do |element, quantity|
      total += price[element] * quantity
    end
  total
  end
end
