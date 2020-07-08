require 'rails_helper'

RSpec.describe 'Pet Delete' do
  it "Destroys a Pet" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_960_720.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/"

    within '.pet-details' do
      expect(page).to have_content("Fido")
    end

    visit "/pets/#{pet_1.id}"

    within '.pet-details' do
      expect(page).to have_content("Fido")
    end

    within '.clickables' do
      expect(page).to have_button("Delete Pet")
      click_on "Delete Pet"
    end

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content("Fido")
    
  end
end
