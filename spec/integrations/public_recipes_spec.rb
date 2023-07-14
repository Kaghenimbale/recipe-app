require 'rails_helper'
RSpec.describe 'Public Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers
  let!(:users) do
    User.create([{ name: 'User one', email: 'user1@example.com', password: 'password', confirmation_token: '23moe234f',
                   confirmed_at: Time.now, confirmation_sent_at: Time.now },
                 { name: 'User two', email: 'user2@example.com', password: 'password',
                   confirmed_at: Time.now, confirmation_sent_at: Time.now }])
  end
  let!(:recipes) do
    Recipe.create!([{ name: 'Recipe One', public: true, description: 'Recipe One Description', user: users[1] },
                    { name: 'Recipe Two', public: true, description: 'Recipe Two Description', user: users[1] },
                    { name: 'Recipe Three', public: false, description: 'Recipe Three Description', user: users[1] }])
  end
  let!(:foods) do
    Food.create!([{ name: 'Food One', price: 10, user: users[1] },
                  { name: 'Food Two', price: 10, user: users[1] },
                  { name: 'Food Three', price: 10, user: users[1] }])
  end
  let!(:recipe_foods) do
    RecipeFood.create!([{ food: foods[0], quantity: 10, recipe: recipes[1] },
                        { food: foods[1], quantity: 10, recipe: recipes[1] },
                        { food: foods[2], quantity: 10, recipe: recipes[1] }])
  end
  before do
    sign_in users[0]
    visit public_recipes_path
  end
  context 'when viewing the page' do
    it 'shows all public recipes.' do
      recipes.each do |recipe|
        expect(page).to have_content(recipe.name) if recipe.public == true
      end
    end
    it 'shows all public recipes authors.' do
      recipes.each do |recipe|
        expect(page).to have_content(recipe.user.name) if recipe.public == true
      end
    end
    it 'When I click on a recipe, it redirects me to that recipe show page' do
      click_on recipes[0].name
      assert_current_path recipe_path(recipes[0])
    end
    context 'calculates the values:' do
      before do
        @total_foods = recipes[1].recipe_foods.count
        @total_price = recipes[1].recipe_foods.joins(:food).sum('foods.price * recipe_foods.quantity')
      end
      it 'it shows the amount of food items in the recipe.' do
        expect(page).to have_content(@total_foods)
      end
      it 'it shows the total price for the recipe.' do
        expect(page).to have_content(@total_price)
      end
    end
  end
end
