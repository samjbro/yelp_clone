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
      expect(page).to have_content('Salad Boutique')
      expect(current_path).to eq '/restaurants'

    end
  end

  context 'viewing restaurants' do

    let!(:salad_boutique){ Restaurant.create(name: 'Salad Boutique') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Salad Boutique'
      expect(page).to have_content 'Salad Boutique'
      expect(current_path).to eq "/restaurants/#{salad_boutique.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end
end
