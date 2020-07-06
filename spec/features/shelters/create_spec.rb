require 'rails_helper'

RSpec.describe "shelters creation page", type: :feature do
  it "can create a new shelter with a shelter name, address, city, state, zip" do

    visit "/shelters"
    expect(page).to have_content("New Shelter")

    click_link('New Shelter')
    expect(current_path).to have_content("/shelters/new")

    expect(page).to have_content("Name")
    expect(page).to have_content("Address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip")

    fill_in("Name", :with => "Joe's Shelter")
    fill_in("Address", :with => "123 Apple St.")
    fill_in("City", :with => "Denver")
    fill_in("State", :with => "CO")
    fill_in("Zip", :with => 80202)

    click_button('Create Shelter')
    expect(current_path).not_to have_content("/new")

    expect(page).to have_content("Joe's Shelter")
  end
end
