require 'rails_helper'

RSpec.describe "pets detail page", type: :feature do
  it "displays the details of a particular pet" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202, id: 1)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/#{pet_1.id}"

    within '.pet-details' do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.approx_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.adoptable?)
    end
  end

  it "displays all pet applications this pet is on" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob",
      address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    application2 = Application.create!(name: "Jill",
      address: "1235 Fake St", city: "Denver", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    PetApplication.create(pet: pet_1, application: application1)
    PetApplication.create(pet: pet_2, application: application1)
    PetApplication.create(pet: pet_2, application: application2)

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("View all applications for this pet")
    click_on "View all applications for this pet"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    expect(page).to have_content("#{application1.name}")
    expect(page).to have_link("#{application1.name}")

    visit "/pets/#{pet_2.id}"

    expect(page).to have_content("View all applications for this pet")
    click_on "View all applications for this pet"

    expect(current_path).to eq("/pets/#{pet_2.id}/applications")

    expect(page).to have_content("#{application1.name}")
    expect(page).to have_link("#{application1.name}")
    expect(page).to have_content("#{application2.name}")
    expect(page).to have_link("#{application2.name}")
  end

  it 'does not allow deletion of a pet with approved application' do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob",
      address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    application2 = Application.create!(name: "Jill",
      address: "1235 Fake St", city: "Denver", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    PetApplication.create(pet: pet_1, application: application1)
    PetApplication.create(pet: pet_2, application: application1)
    PetApplication.create(pet: pet_2, application: application2)

    visit "/applications/#{application1.id}"

    within "#pet-#{pet_2.id}" do
      expect(page).to have_link("Approve Application")
      click_on "Approve Application"
    end

    visit "/pets/#{pet_2.id}"

    within ".clickables" do
      expect(page).to_not have_button("Delete Pet")
    end

    visit "/pets"

    within ".pet-details" do
      expect(page).to_not have_button("Delete #{pet_2.name}")
    end
  end

  it 'will delete pet from favorites if deleted from database' do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/#{pet_1.id}"

    click_button "Add Pet to Favorites"

    visit '/favorites'

    expect(page).to have_content("#{pet_1.name}")

    visit "/pets/#{pet_1.id}"

    click_button 'Delete Pet'

    within '.nav-bar' do
      expect(page).to have_content("Pets Favorited: 0")
    end
  end

  it 'pet name on each page is link to pet show page' do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob",
      address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126,
      phone: "123-456-7890", description: "I love animals!")
    PetApplication.create(pet: pet_2, application: application1)

    visit "/applications/#{application1.id}"

    within "#pet-#{pet_2.id}" do
      expect(page).to have_link("Zorba")
      click_on "Zorba"
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")

    visit "/pets/#{pet_2.id}/edit"

    expect(page).to have_link("Zorba")
    click_on "Zorba"

    expect(current_path).to eq("/pets/#{pet_2.id}")
  end
end
