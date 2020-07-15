require 'rails_helper'

RSpec.describe 'When I visit the shelter show details page' do
  it "I can destroy a shelter" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)

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

  it "cannot delete a shelter if one of its pets has pending status" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob", address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
    PetApplication.create(pet: pet_1, application: application1)
    PetApplication.create(pet: pet_2, application: application1)

    visit "/shelters/#{shelter_1.id}"

    within '.clickables' do
      expect(page).to have_button("Delete Shelter")
    end

    visit "/applications/#{application1.id}"

    within "#pet-#{pet_1.id}" do
      click_on "Approve Application"
    end

    visit "/shelters/#{shelter_1.id}"

    within '.clickables' do
      expect(page).to_not have_button("Delete Shelter")
    end
  end

  it "can delete a shelter as long as all pets do not have approved applications on them" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob", address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
    PetApplication.create(pet: pet_1, application: application1)
    PetApplication.create(pet: pet_2, application: application1)

    visit "/pets/"

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")

    visit "/shelters/#{shelter_1.id}"

    within '.clickables' do
      click_on("Delete Shelter")
    end

    visit "/shelters"
    expect(page).to_not have_content("#{shelter_1.name}")

    visit "/pets"
    expect(page).to_not have_content("#{pet_1.name}")
    expect(page).to_not have_content("#{pet_2.name}")
  end

  it "deletes all shelter reviews when a shelter is deleted" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")

    visit "/shelters/#{shelter_1.id}"

    expect(Review.all.include?(review_1)).to eq(true)

    expect(page).to have_content("#{review_1.title}")
    expect(review_1.title).to eq("Loved it!")

    within '.clickables' do
      click_on("Delete Shelter")
    end

    expect(Review.all.include?(review_1)).to eq(false)
  end
end
