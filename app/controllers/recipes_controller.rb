class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @user = current_user
    @recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { post: @recipe, user: @user } }
    end
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:public])
    head :ok
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(recipe_params)
    respond_to do |format|
      format.html do
        if @recipe.save
          flash[:success] = 'Recipe saved successfully'
          redirect_to recipes_url
        else
          flash.now[:error] = 'Error: Recipe could not be saved'
          render :new
        end
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.recipe_foods.present?
      @recipe.recipe_foods.destroy_all
    end
    @recipe.destroy
    redirect_to recipes_url
  end

  private

  def recipe_params
    params.require(:new_recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
