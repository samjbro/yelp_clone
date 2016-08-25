require 'rails_helper'
require_relative 'helpers/sign_in_helper'

feature 'reviewing' do
  before do
    user = User.create!(password: '123456', email: 'brandnewuser@test.com')
    user.restaurants.create name: 'KFC'
  end

  scenario 'allows users to leave a review using a form' do
    sign_up
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

end
