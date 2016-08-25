require 'rails_helper'
require_relative 'helpers/sign_in_helper'

feature 'reviewing: ' do
  fixtures :restaurants, :reviews

  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant(name: 'KFC')
    expect{create_a_review(restaurant: 'KFC')}.to change(Review, :count).by(1)
  end

  context 'user has created a review' do
    before(:each) do
      sign_up
      create_restaurant(name: 'KFC')
      create_a_review(restaurant: 'KFC')
    end
    scenario 'users can delete their review' do
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).to have_content('Review deleted successfully')
    end
  end
  context 'user has not created a review' do
    scenario "users cannot delete someone else's review" do
      visit '/restaurants'
      click_link 'Burger King'
      expect(page).to have_content('delicious')
      expect(page).not_to have_content('Delete Review')
    end
  end

end
