require 'rails_helper'


feature 'restaurants' do
  context 'when there are no restaurants' do
    scenario 'should have a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
