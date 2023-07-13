class GeneralShoppingListController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @foods = @user.foods
    @recipe_foods = @user.recipes.joins(recipe_foods: :food)
                    .select("foods.name AS food_name, foods.price AS food_price, foods.quantity AS food_quantity, SUM(recipe_foods.quantity) AS total_amount")
                    .group("foods.name, foods.price, foods.quantity")
                    .to_a

    ##@total = 0
    #current_user.foods.each do |food|
    #  @total += food.price * food.quantity
    #end
  end
end
