require 'rails_helper'

RSpec.describe "Pets Edit" do
  it "edits the details of a particular pet" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("Update Pet")
    expect(page).to_not have_content("Zorba")
    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Zorba"
    fill_in :description, with: "Super Fuzzy"
    fill_in :approx_age, with: 2
    fill_in :sex, with: "M"

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Zorba")
  end
end
