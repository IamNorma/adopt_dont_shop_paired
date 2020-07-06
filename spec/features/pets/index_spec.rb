require 'rails_helper'

RSpec.describe 'pets index page' do
  it "displays a list of all pets with their details" do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    shelter_2 = Shelter.create!(name: "Denny's Shelter", address: "456 Main Ave.", city: "New York", state: "NY", zip: 10001)
    dog_1 = shelter_1.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, status: true)
    dog_2 = shelter_2.pets.create!(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/husky_sideways_dog_pictures_.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_2.name, status: true)

    visit "/pets"
    expect(page).to have_content(dog_1.name)
    expect(page).to have_content(dog_1.shelter_name)
    expect(page).to have_content(dog_1.sex)
    expect(page).to have_content(dog_1.approx_age)

    expect(page).to have_content(dog_2.name)
    expect(page).to have_content(dog_2.shelter_name)
    expect(page).to have_content(dog_2.sex)
    expect(page).to have_content(dog_2.approx_age)
  end
end
