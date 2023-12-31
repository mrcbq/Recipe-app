class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    @recipes = current_user.recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe_food = RecipeFood.where(recipe_id: params[:id])
    # p @recipe_food
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.user = current_user
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true)
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    toggle_public
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)

    redirect_to recipe_url(@recipe), notice: 'Public status was successfully updated.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
