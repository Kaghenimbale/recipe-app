require 'rails_helper'

RSpec.describe Food, type: :system do
  chef = User.create(name: 'shafiu')
  subject { Food.create(name: 'pizza', measurement_unit: 'grams', price: 2.5, quantity: 4, user: chef) }
  describe 'Validations' do
    it 'price and quantity should be numeric' do
      expect(subject).to_not be_valid unless subject.price.is_a?(Numeric) && subject.quantity.is_a?(Numeric)
    end

    it 'price and quantity should be numeric' do
      expect(subject.price).to be_a(Numeric)
    end

    it 'price and quantity should be numeric' do
      expect(subject.quantity).to be_a(Numeric)
    end

    it 'shows the right content' do
      visit root_path
      expect(page).to have_content('Email')
    end
  end
end

RSpec.describe 'Foods', type: :system do
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
    @food_one = @user.foods.create(name: 'Food One', price: '$10.99')

    sign_in @user # Authenticate the user
  end

  describe 'User visits the foods index page' do
    before(:each) do
      visit foods_path
    end

    scenario 'I can see a food name' do
      assert_text @food_one.name
    end
  end

  describe 'User visits the food page' do
    before(:each) do
      visit foods_path
    end

    scenario 'I can see a food name' do
      assert_text @food_one.name
    end

    scenario 'I can see the price' do
      assert_text @food_one.price
    end

    scenario 'When I click on Add food, it redirects me to the foods index page' do
      click_link 'Add Food'
      assert_current_path new_food_path
    end
  end
end
