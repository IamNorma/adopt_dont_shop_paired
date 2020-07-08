require 'rails_helper'

RSpec.describe "Creating a new Favorite" do
  xit "creates a new pet favorite" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Max", approx_age: 3, sex: "M", shelter_name: shelter_1.name, description: "A good pet!", status: true)

    visit "/pets/#{pet_1.id}"

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end

    within '.actions' do

      expect(page).to have_content("Favorite This Pet")
    end

    within '.clickables' do
      click_on "Favorite This Pet"
    end

    within '.messages' do
      expect(page).to have_content("Pet Added to Favorites!")
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 1")
    end

    visit "/pets/#{pet_2.id}"

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 1")
    end

    within '.actions' do
      expect(page).to have_content("Favorite This Pet")
    end

    within '.clickables' do
      click_on "Favorite This Pet"
    end

    expect(page).to have_content("Pet Added to Favorites!")
    expect(current_path).to eq("/pets/#{pet_2.id}")
    expect(page).to have_content("Pets Favorited: 2")
  end
end
