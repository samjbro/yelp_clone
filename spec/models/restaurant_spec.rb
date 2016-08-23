require 'rails_helper'

RSpec.describe Restaurant, type: :model do

it 'is not valid with a name less than a 3 characters' do
  restaurant = Restaurant.new(name: 'KF')
  expect(restaurant).to have(1).error_on(:name)
  expect(restaurant).not_to be_valid
end

end
