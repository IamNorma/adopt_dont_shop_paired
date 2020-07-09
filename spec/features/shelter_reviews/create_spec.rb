require 'rails_helper'

RSpec.describe 'review create page' do
  before :each do
    @shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
  end
  it "creates a new shelter review" do
    visit "/shelters/#{@shelter_1.id}"

    within '.clickables' do
      expect(page).to have_link("Add a new shelter review")
      click_on "Add a new shelter review"
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

    title = "A great place"
    rating = 4.5
    content = "Had a great time"
    image = "https://homepages.cae.wisc.edu/~ece533/images/cat.png"

    within '.form' do
      expect(page).to have_content("Title")
      fill_in :title, with: title
      fill_in :rating, with: rating
      fill_in :content, with: content
      fill_in :optional_image_link, with: image
      click_button "Create Review"
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    within '.review-details' do
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content(rating)
    end
  end

  it "shows an error message if not filling out the create review fields properly" do
    rating = 4.5
    content = "Had a great time"
    image = "https://homepages.cae.wisc.edu/~ece533/images/cat.png"

    visit "/shelters/#{@shelter_1.id}/reviews/new"

    within '.form' do
      fill_in :rating, with: rating
      fill_in :content, with: content
      fill_in :optional_image_link, with: image
      click_button "Create Review"
    end

    within '.messages' do
      expect(page).to have_content("This is an invalid review! Please re-enter.")
    end

    within '.form' do
      expect(page).to have_button('Create Review')
    end
  end
end
