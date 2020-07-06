require 'rails_helper'

RSpec.describe "pets detail page", type: :feature do
  it "displays the details of a particular pet" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202, id: 1)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approx_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.adoptable?)
  end
end
