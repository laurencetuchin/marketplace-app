# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "John Smith", email: "johnsmith@example.com", password: "password", password_confirmation: "password", username: "username123", address: "123 Fake street", location: "narnia")

if Product.count < 5
  20.times do
    Product.create(description: 'Product 1 description', 
        price: 100, 
        image: 'http://placehold.it/200x200',
        condition: 'new',
        colour: 'red',
        size: '154cm',
        brand: 'brand 1',
        title: 'title 1')
    end
    puts "Created #{Product.count} products"
end


