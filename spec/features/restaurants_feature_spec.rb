require 'rails_helper'

feature 'restaurants' do
  context 'when there are no restaurants' do
    scenario 'should have a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompt users to fill out a form, and then display the results' do
      sign_up
      create_restaurant
      click_button 'Create Restaurant'
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
      create_restaurant
      expect{click_button 'Create Restaurant'}.to change(Restaurant, :count).by(1)
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
    let!(:kfc) { Restaurant.create(name: 'KFC') }
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
      before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

      scenario 'lets a user edit a restaurant' do
        sign_up
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(page).to have_content 'Deep fried goodness'
        expect(current_path).to eq '/restaurants'
      end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }
    scenario 'removes a restaurant when user clicks delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
