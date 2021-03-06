require 'rails_helper'

RSpec.describe "Favorites index page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    @pet_1 = @shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: @shelter_1.name, description: "A furry friend!", status: true)
    @pet_2 = @shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: @shelter_1.name, status: true)
    @pet_3 = @shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Max", approx_age: 5, sex: "F", shelter_name: @shelter_1.name, status: true)
  end

  it "displays the information of all pets favorited" do
    visit "/favorites"

    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_1.image)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_2.image)

    visit '/pets'

    within("#pet-#{@pet_1.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/pets'

    within("#pet-#{@pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit "/favorites"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

    click_on "Zorba"
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    visit "/favorites"
    click_on "Fido"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "allows the user to remove a pet from their favorites" do
    visit '/pets'
    expect(page).to have_content("Fido")
    expect(page).to have_content("Zorba")
    within("#pet-#{@pet_1.id}") do
      click_button "Add Pet to Favorites"
    end
    visit '/pets'
    within("#pet-#{@pet_2.id}") do
      click_button "Add Pet to Favorites"
    end
    visit '/favorites'
    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 2")
    end

    within ("#pet-#{@pet_1.id}") do
      expect(page).to have_content("Remove Pet From Favorites")
      click_on "Remove Pet From Favorites"
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 1")
    end

    visit '/pets'
    expect(page).to have_content("Fido")
    expect(page).to have_content("Zorba")
  end

  it "shows no favorites when no pets have been favorited" do
    visit '/pets'
    within("#pet-#{@pet_1.id}") do
      click_button "Add Pet to Favorites"
    end
    visit '/pets'
    within("#pet-#{@pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/favorites'

    within ("#pet-#{@pet_1.id}") do
      click_on "Remove Pet From Favorites"
    end

    visit '/favorites'

    within ("#pet-#{@pet_2.id}") do
      click_on "Remove Pet From Favorites"
    end

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end

    visit '/favorites'

    expect(page).to_not have_content("Remove Pet From Favorites")
    expect(page).to_not have_content("Fido")
    expect(page).to_not have_content("Zorba")

    expect(page).to have_content("No pets have been favorited yet")
  end

  it "removes all favorites from the favorites page" do
    visit '/pets'
    within("#pet-#{@pet_1.id}") do
      click_button "Add Pet to Favorites"
    end
    visit '/pets'
    within("#pet-#{@pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/favorites'

    expect(page).to have_content("Remove all Favorited Pets")
    click_on "Remove all Favorited Pets"
    expect(current_path).to eq("/favorites")

    expect(page).to_not have_content("Remove Pet From Favorites")
    expect(page).to_not have_content("Fido")
    expect(page).to_not have_content("Zorba")

    expect(page).to have_content("No pets have been favorited yet")

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end

    visit '/pets'
    within("#pet-#{@pet_1.id}") do
      click_button "Add Pet to Favorites"
    end
    visit '/pets'
    within("#pet-#{@pet_2.id}") do
      click_button "Add Pet to Favorites"
    end

    visit '/favorites'

    expect(page).to have_content("Remove all Favorited Pets")
    click_on "Remove all Favorited Pets"
    expect(current_path).to eq("/favorites")

    expect(page).to_not have_content("Remove Pet From Favorites")
    expect(page).to_not have_content("Fido")
    expect(page).to_not have_content("Zorba")

    expect(page).to have_content("No pets have been favorited yet")

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end
  end

  it 'displays list of pets with applications' do
    application1 = Application.create!(name: "Bob",
      address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    application2 = Application.create!(name: "Jill",
      address: "1235 Fake St", city: "Denver", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")

    PetApplication.create(pet: @pet_1, application: application1)
    PetApplication.create(pet: @pet_2, application: application2)

    visit '/favorites'

    within '.applied-for' do
      expect(page).to have_content("Fido")
      expect(page).to have_content("Zorba")
      expect(page).to have_link("Fido")
      expect(page).to have_link("Zorba")
    end
  end
end
