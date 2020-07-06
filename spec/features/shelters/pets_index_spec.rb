require 'rails_helper'

RSpec.describe "Shelter Pets Index" do
  it "displays the details of a pet that belows to a shelter" do
    shelter_1 = Shelter.create(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
    shelter_1.pets.create(image: "/Users/dan/turing/2module/adopt_dont_shop_2005/app/assets/images/afghanhound_dog_pictures_.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name)

    visit "/shelters/#{shelter_1.id}/pets"

    name = "Fido"
    approx_age = 3
    sex = "F"

    expect(page).to have_content(name)
    expect(page).to have_content(sex)
    expect(page).to have_content(approx_age)
  end
end
