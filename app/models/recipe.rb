class Recipe < ApplicationRecord
  belongs_to :user

  def is_public?
    self.public
  end
end
