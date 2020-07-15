require 'rails_helper'

RSpec.describe 'Pet applications index page' do
  it 'shows message if pet has no applicaitons' do
    shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "pets/#{pet_1.id}/applications"

    expect(page).to have_content("There are no applications for this pet.")
  end
end
