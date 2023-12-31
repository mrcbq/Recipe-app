class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
    @food.user = current_user
  end

  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_url, notice: 'Food was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
    end
  end

  def general_shopping_list
    @recipes = Recipe.where(user: current_user)
    @recipe_foods = RecipeFood.where(recipe: @recipes)
    @foods = Food.where(user: current_user)

    @needs = helpers.calculate_total_items(@recipe_foods)
    @array = helpers.calculate_food_totals(@foods)
    @inventory = @array[0]
    @prices = @array[1]

    @shop = helpers.calculate_totals_needed(@inventory, @needs)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
