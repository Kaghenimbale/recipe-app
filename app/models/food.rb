class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :recipe_foods

  validates :name, uniqueness: { scope: :user_id }
end
