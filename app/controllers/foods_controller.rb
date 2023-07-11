class FoodsController < ApplicationController
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
      redirect_to root_path, notice: 'Food created successfully.'
    else
      puts @food.errors.full_messages
      redirect_to root_path, alert: 'Failed to create Food!'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food deleted successfully.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end

