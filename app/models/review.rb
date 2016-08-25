class Review < ApplicationRecord

  validates :rating, inclusion: (1..5)
  belongs_to :restaurant
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: 'has reviewed this restaurant already' }

end
