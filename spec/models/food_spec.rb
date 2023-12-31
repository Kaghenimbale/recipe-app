require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.create(
      name: 'User one',
      email: 'user@example.com',
      password: 'password',
      confirmation_token: '23moe234f',
      confirmed_at: Time.now,
      confirmation_sent_at: Time.now
    )
    @food = @user.foods.create(name: 'Food One', price: '10.99')
  end

  describe 'validations' do
    it 'is valid with a name and price' do
      expect(@food).to be_valid
    end

    it 'is invalid with an invalid price format' do
      @food.price = 'abc'
      expect(@food).to_not be_invalid
    end

    it 'is invalid with a name less than 3 characters' do
      @food.name = 'ab'
      expect(@food).to_not be_invalid
    end

    it 'is invalid with a name more than 50 characters' do
      @food.name = 'a' * 51
      expect(@food).to_not be_invalid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(@food.user).to eq(@user)
    end

    it 'has many recipe_foods' do
      expect(@food.recipe_foods).to be_empty
    end
  end
end
