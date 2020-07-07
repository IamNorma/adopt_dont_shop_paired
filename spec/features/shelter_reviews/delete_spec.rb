require 'rails_helper'

RSpec.describe 'review delete' do
  it "deletes a shelter review" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("#{review_1.title}")
    expect(page).to have_content("#{review_1.rating}")
    expect(page).to have_content("#{review_1.content}")

    expect(page).to have_button("Delete Shelter Review")
    click_on "Delete Shelter Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to_not have_content("#{review_1.title}")
    expect(page).to_not have_content("#{review_1.rating}")
    expect(page).to_not have_content("#{review_1.content}")
  end
end
