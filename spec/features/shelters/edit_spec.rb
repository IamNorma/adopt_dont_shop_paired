require 'rails_helper'

RSpec.describe "Shelter Edit" do
  it "can edit details of a particular shelter" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to_not have_content("Bob")
    expect(page).to have_content("Update Shelter")

    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in :name, with: "Bob's Shelter"
    fill_in :address, with: "222 Nowhere Pl."
    fill_in :city, with: "Jacksonville"
    fill_in :state, with: "FL"
    fill_in :zip, with: 20002

    click_on "Submit"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Bob's Shelter")
  end
end
