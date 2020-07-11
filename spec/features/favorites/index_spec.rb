require 'rails_helper'

RSpec.describe "Favorites index page" do
  it "displays the information of all pets favorited" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)

    visit "/favorites"

    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_1.image)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_2.image)

    visit '/pets'

    within("#pet-#{pet_1.id}") do
      click_button "Add Pet to Favorites"
    end

    within("#pet-#{pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit "/favorites"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)

    click_on "Zorba"
    expect(current_path).to eq("/pets/#{pet_2.id}")

    visit "/favorites"
    click_on "Fido"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
