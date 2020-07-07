require 'rails_helper'

RSpec.describe 'shelter reviews index page' do
  it "displays a list of all shelter reviews with their details" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
    review_2 = shelter_1.reviews.create!(title: "Had a blast!", rating: 5, content: "Great facility!")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_content(review_1.image)

    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)
  end
end
