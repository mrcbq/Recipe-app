class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[ destroy ]

  # GET /recipe_foods/new
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    @available_foods = Food.all
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = @recipe_food.recipe

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe), notice: 'Recipe food was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe = @recipe_food.recipe
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe), notice: 'Recipe food was successfully deleted.' }
  
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
