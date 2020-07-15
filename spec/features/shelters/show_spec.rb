require 'rails_helper'

RSpec.describe "shelters detail page", type: :feature do
  it "can see the details of a particular shelter" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    shelter_2 = Shelter.create(name: "Denny's Shelter", address: "456 Main Ave.", city: "New York", state: "NY", zip: 10001)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Shelter Name: #{shelter_1.name}")
    expect(page).to have_content("Shelter Address: #{shelter_1.address}")
    expect(page).to have_content("Shelter City: #{shelter_1.city}")
    expect(page).to have_content("Shelter State: #{shelter_1.state}")
    expect(page).to have_content("Shelter Zip: #{shelter_1.zip}")

    visit "/shelters/#{shelter_2.id}"

    expect(page).to have_content("Shelter Name: #{shelter_2.name}")
    expect(page).to have_content("Shelter Address: #{shelter_2.address}")
    expect(page).to have_content("Shelter City: #{shelter_2.city}")
    expect(page).to have_content("Shelter State: #{shelter_2.state}")
    expect(page).to have_content("Shelter Zip: #{shelter_2.zip}")
  end

  it 'everywhere the shelter name appears it is a link to the shelter show page' do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)

    visit "/shelters/#{shelter_1.id}/edit"

    expect(page).to have_link("Joe's Shelter")
    click_on "Joe's Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end

  it "displays shelter statistics" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
    pet_2 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
    application1 = Application.create!(name: "Bob", address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
    application2 = Application.create!(name: "Jill", address: "1235 Fake St", city: "Denver", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
    review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
    review_2 = shelter_1.reviews.create!(title: "Great!", rating: 4, content: "Not bad!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
    review_2 = shelter_1.reviews.create!(title: "Really good!", rating: 4.7, content: "Very good!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
    PetApplication.create(pet: pet_1, application: application1)
    PetApplication.create(pet: pet_1, application: application2)
    PetApplication.create(pet: pet_2, application: application2)

    visit "/shelters/#{shelter_1.id}"

    within '.statistics' do
      expect(page).to have_content "Number of pets in this shelter: #{shelter_1.pet_count}"
      expect(page).to have_content "Number of pets in this shelter: 2"
      expect(page).to have_content "Average shelter review rating: #{shelter_1.average_review_rating}"
      expect(page).to have_content "Average shelter review rating: 4.4"
      expect(page).to have_content "Number of applications on file for pets in this shelter: #{shelter_1.application_count}"
      expect(page).to have_content "Number of applications on file for pets in this shelter: 3"
    end
  end
end
