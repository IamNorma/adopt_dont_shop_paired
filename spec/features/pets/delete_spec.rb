require 'rails_helper'

RSpec.describe 'Pet Delete' do
  it "Destroys a Pet" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    pet_1 = shelter_1.pets.create(image: "https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_960_720.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)

    visit "/pets/"
    expect(page).to have_content("Fido")

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("Fido")
    expect(page).to have_button("Delete Pet")

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content("Fido")
  end
end
