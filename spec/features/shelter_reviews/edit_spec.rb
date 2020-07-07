require 'rails_helper'

RSpec.describe 'review edit page' do
  it "edits a shelter review" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Edit Shelter Review")
    click_on "Edit Shelter Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

    expect(find_field("Title").value).to eq("#{review_1.title}")
    expect(find_field("Rating").value).to eq("#{review_1.rating}")
    expect(find_field("Content").value).to eq("#{review_1.content}")

    title = "A pretty good place"
    rating = 3.5

    fill_in :title, with: title
    fill_in :rating, with: rating

    click_button "Edit Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to have_content(title)
    expect(page).to have_content("#{review_1.content}")
    expect(page).to have_content(rating)
  end

  it "shows an error message if not filling out the edit review fields properly" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")

    content = "Had a so-so time"
    image = "https://homepages.cae.wisc.edu/~ece533/images/cat.png"

    visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"
    
    fill_in :rating, with: ''
    fill_in :content, with: content
    fill_in :optional_image_link, with: image
    click_button "Edit Review"

    expect(page).to have_content("This is an invalid edit to a review! Please re-enter.")
    expect(page).to have_button('Edit Review')
  end
end
