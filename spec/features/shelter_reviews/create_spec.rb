require 'rails_helper'

RSpec.describe 'review create page' do
  it "creates a new shelter review" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Add a new shelter review")
    click_on "Add a new shelter review"

    expect(current_path).to eq("/reviews/new")

    title = "A great place"
    rating = 4.5
    content = "Had a great time"
    image = "https://homepages.cae.wisc.edu/~ece533/images/cat.png"

    expect(page).to have_content("Title")
    fill_in :title, with: title
    fill_in :rating, with: rating
    fill_in :content, with: content
    fill_in :optional_image, with: image

    click_button "Create Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to have_content(title)
    expect(page).to have_content(content)
    expect(page).to have_content(rating)
    expect(page).to have_content(image)
  end
end