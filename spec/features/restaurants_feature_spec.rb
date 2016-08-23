require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'it should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content "No restaurants yet"
      expect(page).to have_link "Add a restaurant"
    end
  end


  context 'restaurants have been added' do

    before do
      Restaurant.create(name: 'Salad Boutique')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Salad Boutique')
      expect(page).not_to have_content "No restaurants yet"
    end
  end

  context 'creating restaurants' do
    scenario 'promots user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Salad Boutique'
      click_button 'Create Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('Salad Boutique')
    end
  end
end
