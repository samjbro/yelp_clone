require 'rails_helper'

feature 'restaurants' do
  fixtures :restaurants

  context 'restaurants have been added' do

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Burger King')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompt users to fill out a form, and then display the results' do
      sign_up
      create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario "user must be signed in to create a restaurant" do
      visit "/"
      click_link "Add a restaurant"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end

    scenario "signed in user creating a restaurant increases count by 1" do
      sign_up
      expect{create_restaurant}.to change(Restaurant, :count).by(1)
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        visit '/'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KF'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'KF'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'view restaurants' do
    scenario 'lets a user view a restaurant' do
      restaurant = restaurants(:burger_king)
      visit '/restaurants'
      click_link 'Burger King'
      expect(page).to have_content 'Burger King'
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context 'editing restaurants' do

      scenario 'lets a user edit a restaurant that they have created' do
        sign_up
        create_restaurant
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
        expect(current_path).to eq '/restaurants'
      end
      scenario 'does not let a user edit a restaurant that they have not created' do
        sign_up
        expect(page).not_to have_content 'Edit Burger King'
      end
  end

  context 'deleting restaurants' do
    scenario 'lets a user delete a restaurant that they have created' do
      sign_up
      create_restaurant
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
    scenario 'does not let a user delete a restaurant that they have not created' do
      sign_up
      create_restaurant
      expect(page).not_to have_content 'Delete Pizza Hut'
    end
  end

end
