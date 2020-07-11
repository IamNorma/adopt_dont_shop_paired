require 'rails_helper'

RSpec.describe "When a user adds a pet to their favorites" do
  it "displays a message" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets"

    within("#pet-#{pet_1.id}") do
      click_button "Add Pet to Favorites"
    end

    #flash message
    within '.messages' do
      expect(page).to have_content("You now have 1 pet in your favorites!")
    end
  end

  it "the message correctly increments for multiple pets" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)

    visit "/pets/#{pet_1.id}"

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end

    within(".clickables") do
      click_button "Add Pet to Favorites"
    end

    within '.messages' do
      expect(page).to have_content("You now have 1 pet in your favorites!")
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 1")
    end

    visit "/pets/#{pet_2.id}"

    within(".clickables") do
      click_button "Add Pet to Favorites"
    end

    within '.messages' do
      expect(page).to have_content("You now have 2 pets in your favorites!")
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 2")
    end
  end

  it "user can't favorite a pet more than once" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)

    visit "/pets/#{pet_1.id}"

    within(".clickables") do
      expect(page).to have_button("Add Pet to Favorites")
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end

    within '.clickables' do
      click_button "Add Pet to Favorites"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 1")
    end

    within(".clickables") do
      expect(page).to_not have_button("Add Pet to Favorites")
      expect(page).to have_button("Remove From Favorites")
      click_button "Remove From Favorites"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within '.messages' do
      expect(page).to have_content("You have removed this pet from your favorites")
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within(".clickables") do
      expect(page).to have_button("Add Pet to Favorites")
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end
  end

  it "displays link in nav bar to go to favorites index page" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)

    visit '/pets'

    within("#pet-#{pet_1.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/pets'

    within("#pet-#{pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 2")
      expect(page).to have_link("Pets Favorited: 2")
      click_on "Pets Favorited: 2"
    end

    expect(current_path).to eq('/favorites')

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end
