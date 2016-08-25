require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  it 'is not valid with a name less than a 3 characters' do
    restaurant = Restaurant.new(name: 'KF')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    user = User.create!(password: '123456', email: 'brandnewuser@test.com')
    user.restaurants.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe '#average_rating' do
    let!(:restaurant) { Restaurant.create(name: 'The Ivy') }

    context 'no reviews' do
      it "returns 'N/A' when there are no reviews" do
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context 'one review' do
      it 'returns that rating' do
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end
    context 'multiple reviews' do
      it 'returns the average_rating' do
        restaurant.reviews.create(rating: 1)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 3
      end
    end
  end

  describe 'reviews' do
    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, thoughts: 'yum'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the user' do
        expect(review.user).to eq user
      end

    end
  end
end
