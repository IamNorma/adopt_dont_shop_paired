# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Review.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(name: "Joe's Shelter", address: "123 Apple St.", city: "Denver", state: "CO", zip: 80202)
shelter_2 = Shelter.create!(name: "Jill's Shelter", address: "123 Hello Pl.", city: "New York", state: "NY", zip: 10001)
review_1 = shelter_1.reviews.create!(title: "Loved it!", rating: 4.5, content: "Had a great time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
review_2 = shelter_1.reviews.create!(title: "Great", rating: 4.7, content: "Had a wonderful time!", image: "https://commons.wikimedia.org/wiki/File:Ljubljana_Slovenia_animal_shelter.JPG")
review_3 = shelter_2.reviews.create!(title: "Very good", rating: 4.3, content: "Really good shelter", image: "https://p0.pikist.com/photos/545/802/dog-animal-cute-bitch-outdoors-portrait-of-a-dog-the-head-of-the-happy-dog-black-dog.jpg")
review_4 = shelter_2.reviews.create!(title: "Awesome", rating: 4.9, content: "Great service!", image: "https://p0.pikist.com/photos/545/802/dog-animal-cute-bitch-outdoors-portrait-of-a-dog-the-head-of-the-happy-dog-black-dog.jpg")
pet_1 = shelter_1.pets.create!(image: "https://upload.wikimedia.org/wikipedia/commons/0/0d/A_type_of_dog.jpg", name: "Fido", approx_age: 3, sex: "F", shelter_name: shelter_1.name, description: "A furry friend!", status: true)
pet_2 = shelter_1.pets.create!(image: "https://c1.peakpx.com/wallpaper/765/223/721/dog-pet-animals-cobblestone-wallpaper-preview.jpg", name: "Zorba", approx_age: 2, sex: "M", shelter_name: shelter_1.name, status: true)
pet_3 = shelter_2.pets.create!(image: "https://pixabay.com/get/52e8dd454a52af14f1dc8460da2932771137daec525870_640.jpg", name: "Spot", approx_age: 2, sex: "F", shelter_name: shelter_2.name, description: "A happy dog!", status: true)
pet_4 = shelter_2.pets.create!(image: "https://p0.pikist.com/photos/482/179/dog-portrait-of-dog-eurasier-eurasier-mascot-dog-eurasier-olafblue-dog-breed-companion-animal-adorable.jpg", name: "Charlie", approx_age: 2, sex: "M", shelter_name: shelter_2.name, status: true)
application1 = Application.create!(name: "Bob", address: "123 Fake St", city: "San Diego", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
application2 = Application.create!(name: "Jill", address: "1235 Fake St", city: "Denver", state: "CA", zip: 92126, phone: "123-456-7890", description: "I love animals!")
PetApplication.create!(pet: pet_1, application: application1)
PetApplication.create!(pet: pet_2, application: application1)
PetApplication.create!(pet: pet_3, application: application2)
PetApplication.create!(pet: pet_4, application: application2)
PetApplication.create!(pet: pet_1, application: application2)
