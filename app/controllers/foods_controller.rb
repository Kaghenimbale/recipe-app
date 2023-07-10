class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
  end
end
