class GeneralShoppingListController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @foods = @user.foods
    @recipe_foods = @user.recipes.joins(recipe_foods: :food)
      .select('foods.name AS food_name, foods.price AS food_price, foods.quantity AS food_quantity,
              foods.measurement_unit as food_measurement, SUM(recipe_foods.quantity) AS total_amount,
              (SUM(recipe_foods.quantity)- foods.quantity) AS total_missing')
      .group('foods.name, foods.price, foods.quantity, foods.measurement_unit')
      .to_a
    @count = @recipe_foods.count
    @total_price = @recipe_foods.sum { |recipe_food| recipe_food.food_price * recipe_food.total_missing }

    # #@total = 0
    # current_user.foods.each do |food|
    #  @total += food.price * food.quantity
    # end
  end
end
