# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.create(name: "Nacho")
recipe1 = Recipe.create(name: "Rice and Egg", preparation_time: 1.5, cooking_time: 0.5, description: "Egg and rice", public: true, user: user1)
food1 = Food.create(name: "Egg", measurement_unit: "units", quantity: 14, price: 20.5, user: user1)