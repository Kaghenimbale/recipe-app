class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user if current_user

    if @food.save
      redirect_to request.referrer, notice: 'Food created successfully.'
    else
      redirect_to foods_path, alert: 'Failed to create Food!'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if can? :destroy, @food
      @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfully.'
    else
      redirect_to foods_path, notice: 'You are not allowed to destroy this food.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
