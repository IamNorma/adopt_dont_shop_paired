require 'rails_helper'

RSpec.describe "Creating a pet adoption application" do
  it "submits a form to adopt a pet or multiple pets" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)

    visit '/pets'

    within("#pet-#{pet_1.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/pets'

    within("#pet-#{pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit "/favorites"

    expect(page).to have_content("Adopt your favorited pets")
    click_on "Adopt your favorited pets"

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("Zorba")
    expect(page).to have_content("Fido")

    within '.dropdown' do
      select("Zorba")
      select("Fido")
    end

    within '.form' do
      fill_in :name, with: "Person"
      fill_in :address, with: "123 Nowhere Pl."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80002"
      fill_in :phone, with: "123-456-7890"
      fill_in :description, with: "I love animals"
      click_on "Submit"
    end

    within '.messages' do
      expect(page).to have_content("Application Submitted")
    end

    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content("Fido")
    expect(page).to_not have_content("Zorba")

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end
  end
end
