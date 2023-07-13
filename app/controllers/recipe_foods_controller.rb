class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @foods = @user.foods
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    respond_to do |format|
      format.html { render :new, locals: { post: @recipe_food, user: @user } }
    end
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    respond_to do |format|
      format.html do
        if @recipe_food.save
          redirect_to recipe_url(@recipe), notice: 'Recipe Food created successfully.'
        else
          redirect_to recipe_url(@recipe), alert: 'Failed to create Recipe Food!'
        end
      end
    end
  end

  def modify
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.update(modify_params)
      redirect_to recipe_url(@recipe_food.recipe), notice: 'Recipe Food updated successfully.'
    else
      redirect_to recipe_url(@recipe_food.recipe), notice: 'Failed to update Recipe Food!'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to request.referrer
  end

  private

  def recipe_food_params
    params.require(:new_recipe_food).permit(:food_id, :quantity)
  end

  def modify_params
    params.require(:new_quantity_food).permit(:quantity)
  end
end
