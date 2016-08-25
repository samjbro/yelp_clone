require 'rails_helper'
require_relative 'helpers/sign_in_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'KFC'
    expect(page).to have_content 'so so'
  end

end
