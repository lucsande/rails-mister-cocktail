# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
drinks_serialized = open(url).read
drinks = JSON.parse(drinks_serialized)
ingredients = drinks["drinks"]

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Starting to seed ingredients!'
puts ''

ingredients.each { |ingr| Ingredient.create( name: ingr["strIngredient1"] ) }

puts 'Finished seeding ingredients!'
puts '---------------------------------------'
puts ''
puts 'Seeded the following models:'
Ingredient.all.each { |ingr| puts ingr.name }
puts '---------------------------------------'
puts ''

puts 'Starting to seed a Cold Water!'

water_drink = Cocktail.create!(name: 'Cold Water')
water_ingr = Ingredient.find_by(name:'Water')
# water_ingr = Ingredient.create!(name:'Water')
Dose.create!(quantity: "1", unit: "cup", cocktail_id: water_drink.id, ingredient_id: water_ingr.id)
puts '---------------------------------------'
puts 'Created your Cold Water!'
