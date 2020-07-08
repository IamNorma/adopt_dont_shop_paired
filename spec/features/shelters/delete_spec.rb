require 'rails_helper'

RSpec.describe 'When I visit the shelter show details page' do
  it "I can destroy a shelter" do

    visit "/shelters"

    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)

    visit "/shelters/"

    visit "/shelters/#{shelter_1.id}"
    within '.shelter-details' do
      expect(page).to have_content("Joe's Shelter")
    end

    within '.clickables' do
      expect(page).to have_button("Delete Shelter")
      click_button "Delete Shelter"
    end

    expect(current_path).to eq("/shelters")

    expect(page).to_not have_content("Joe's Shelter")
  end
end
