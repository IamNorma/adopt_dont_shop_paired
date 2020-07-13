require 'rails_helper'

RSpec.describe "Pet application show page" do
  it "displays the details of the application" do
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

    expect(page).to have_content("#{application1.name}")
    expect(page).to have_content("#{application1.address}")
    expect(page).to have_content("#{application1.city}")
    expect(page).to have_content("#{application1.state}")
    expect(page).to have_content("#{application1.zip}")
    expect(page).to have_content("#{application1.phone}")
    expect(page).to have_content("#{application1.description}")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_link("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_link("#{pet_2.name}")

    click_on("#{pet_2.name}")
    expect(current_path).to eq("/pets/#{pet_2.id}")

    visit "/applications/#{application2.id}"

    expect(page).to have_content("#{application2.name}")
    expect(page).to have_content("#{application2.address}")
    expect(page).to have_content("#{application2.city}")
    expect(page).to have_content("#{application2.state}")
    expect(page).to have_content("#{application2.zip}")
    expect(page).to have_content("#{application2.phone}")
    expect(page).to have_content("#{application2.description}")

    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_link("#{pet_2.name}")
  end

  it "displays link to approve application" do
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

    expect(page).to_not have_content("Pending")

    visit "/applications/#{application1.id}"

    within "#pet-#{pet_1.id}" do
      expect(page).to have_link("Approve Application")
      click_on "Approve Application"
    end


    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for #{application1.name}")
  end
end
