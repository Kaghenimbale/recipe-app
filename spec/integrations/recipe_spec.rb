require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(
      name: 'User one',
      email: 'user@example.com',
      password: 'password',
      confirmation_token: '23moe234f',
      confirmed_at: Time.now,
      confirmation_sent_at: Time.now
    )
    @recipe_one = @user.recipes.create(name: 'Recipe One', description: 'Recipe One Description')

    sign_in @user # Authenticate the user
  end

  describe 'User visits the recipes index page' do
    before(:each) do
      visit recipes_path
    end

    scenario 'I can see a recipe name' do
      assert_text @recipe_one.name
    end

    scenario 'I can see some of the recipe description' do
      assert_text @recipe_one.description
    end

    scenario 'When I click on a recipe, it redirects me to that recipe show page' do
      click_on @recipe_one.name
      assert_current_path recipe_path(@recipe_one)
    end
  end

  describe 'User visits the recipe page' do
    before(:each) do
      visit recipe_path(@recipe_one)
    end

    scenario 'I can see a recipe name' do
      assert_text @recipe_one.name
    end

    scenario 'I can see some of the recipe description' do
      assert_text @recipe_one.description
    end
  end
end
