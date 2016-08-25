def sign_up
  visit "/"
  click_link 'Sign up'
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
end

def create_restaurant(name: 'KFC')
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def leave_review(restaurant: 'KFC', rating: 3)
  click_link 'Review ' + restaurant
  fill_in 'Thoughts', with: 'so so'
  select '3', from: 'Rating'
  click_button 'Leave Review'
end
