class FoodsController < ApplicationController
  def index
    @foodS = Food.all
  end

  def show
  end
end
