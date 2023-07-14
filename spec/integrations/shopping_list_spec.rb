require 'rails_helper'
RSpec.describe 'Shopping list', type: :feature do
  include Devise::Test::IntegrationHelpers
  let!(:user) do
    User.create({ name: 'User one', email: 'user1@example.com', password: 'password', confirmation_token: '23moe234f',
                  confirmed_at: Time.now, confirmation_sent_at: Time.now })
  end
  let!(:recipes) do
    Recipe.create!([{ name: 'Recipe One', public: true, description: 'Recipe One Description', user: user },
                    { name: 'Recipe Two', public: true, description: 'Recipe Two Description', user: user },
                    { name: 'Recipe Three', public: false, description: 'Recipe Three Description', user: user }])
  end
  let!(:foods) do
    Food.create!([{ name: 'Food One', price: 10, user: user },
                  { name: 'Food Two', quantity: 5, price: 10, user: user },
                  { name: 'Food Three', price: 10, user: user }])
  end
  let!(:recipe_foods) do
    RecipeFood.create!([{ food: foods[0], quantity: 10, recipe: recipes[0] },
                        { food: foods[1], quantity: 10, recipe: recipes[1] },
                        { food: foods[2], quantity: 10, recipe: recipes[2] }])
  end
  before do
    sign_in user
    visit general_shopping_list_index_path
  end
  context 'when viewing the page' do
    it 'shows all foods of the recipes.' do
      foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end
    context 'calculates the values:' do
      before do
        @foods_recipe = user.recipes.joins(recipe_foods: :food)
          .select('foods.name AS food_name, foods.price AS food_price, foods.quantity AS food_quantity,
                foods.measurement_unit as food_measurement, SUM(recipe_foods.quantity) AS total_amount,
                (SUM(recipe_foods.quantity)- foods.quantity) AS total_missing')
          .group('foods.name, foods.price, foods.quantity, foods.measurement_unit')
          .to_a
        @count = @foods_recipe.count
        @total_price = @foods_recipe.sum { |food_recipe| food_recipe.food_price * food_recipe.total_missing }
      end
      it 'it shows the amount of food items to buy.' do
        expect(page).to have_content(@count)
      end
      it 'it shows the total value of food needed.' do
        expect(page).to have_content(@total_price)
      end
      it 'it shows the foods name needed for all the recipes' do
        @foods_recipe.each do |food|
          expect(page).to have_content(food.food_name)
        end
      end
      it 'it shows the missing quantity of food needed' do
        @foods_recipe.each do |food|
          expect(page).to have_content(food.total_missing)
        end
      end
      it 'it shows the price value for each food needed' do
        @foods_recipe.each do |food|
          expect(page).to have_content((food.food_price * food.total_missing))
        end
      end
    end
  end
end
