class GeneralShoppingListController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = Food.all
    @total = 0
    current_user.foods.each do |food|
      @total += food.price * food.quantity
    end
  end
end
