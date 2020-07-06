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
end
