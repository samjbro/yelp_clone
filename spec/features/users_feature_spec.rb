require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not signed in and on the homepage' do
    it 'should see a "sign in" link and a "sign up" link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'should not see "sign out" link' do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it 'should not see "create restaurant" link' do
      visit('/')
      click_link('Add a restaurant')
      expect(page.current_path).to eq('/users/sign_in')
    end

  end

  context 'user signed in on the homepage' do
    before do
      sign_in
    end

    it 'should no see a "sign in" link and a "sign up" link' do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

  end
end
