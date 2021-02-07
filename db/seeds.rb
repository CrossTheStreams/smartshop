# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Grouping of Faker classes that made some sense to group together

require 'awesome_print'
require 'faker'
require 'pry-rails'

def invoice_price(base_price)
  below_base = (base_price - base_price * 0.1)
  above_base = (base_price + base_price * 0.1)
  rand(below_base..above_base)
end

store_types = [
  {
    :category => "Phone Shop",
    :product_name_faker => Proc.new { Faker::Device.model_name },
    :base_price => 500,
  },
  {
    :category => "Game Store",
    :product_name_faker => Proc.new { Faker::Game.title },
    :base_price => 50,
  },
  {
    :category => "Restaurant",
    :product_name_faker => Proc.new { Faker::Food.dish },
    :base_price => 17,
  },
  {
    :category => "Beer Shop",
    :product_name_faker => Proc.new { Faker::Beer.name },
    :base_price => 10,
  },
  {
    :category => "Bakery",
    :product_name_faker => Proc.new { Faker::Dessert.variety },
    :base_price => 10,
  },
  {
    :category => "Coffee Shop",
    :product_name_faker => Proc.new { Faker::Coffee.blend_name },
    :base_price => 10,
  },
  {
    :category => "Appliances",
    :product_name_faker => Proc.new { "#{Faker::Appliance.brand} #{Faker::Appliance.equipment}" },
    :base_price => 1000,
  },
  {
    :category => "Grocery",
    :product_name_faker => Proc.new { Faker::Food.vegetables },
    :base_price => 10,
  },
  {
    :category => "Fruit Stand",
    :product_name_faker => Proc.new { Faker::Food.fruits },
    :base_price => 3,
  },
  {
    :category => "Co-op",
    :product_name_faker => Proc.new { Faker::Food.ingredient },
    :base_price => 10,
  },
  {
    :category => "Spices",
    :product_name_faker => Proc.new { Faker::Food.spice },
    :base_price => 10,
  },
]

number_of_tenants = ENV["TENANTS"].to_i

puts "Creating seed data for #{number_of_tenants} tenants...".purple

number_of_tenants.times do
  store_type = store_types.sample
  store_type => {category:, product_name_faker:, base_price:}
  company_name = Faker::Company.name
  company = Company.create!(name: "#{company_name} #{category}")
  puts "    Created #{"Company".blue} => #{company.name}"

  3.times do
    first_name, last_name = Faker::FunnyName.unique.two_word_name.split(" ")
    email = "#{first_name.downcase}.#{last_name.downcase}@example.com"
    user = User.create!(
      email: email,
      first_name: first_name,
      last_name: last_name,
      company: company,
      password: "secretpassword",
    )
    puts "        Created #{"User".green} with email => #{user.email}"
  end

  100.times do
    name = product_name_faker.call
    description = Faker::Lorem.paragraph(sentence_count: 3)
    invoice_price = invoice_price(base_price)
    msrp_price = (invoice_price + invoice_price * 0.03)
    retail_price = (invoice_price + invoice_price * 0.05)

    product = Product.create!(
      name: name,
      description: description,
      invoice_price: invoice_price,
      msrp_price: msrp_price,
      retail_price: retail_price,
      current_stock: rand(0..30),
      uuid: SecureRandom.uuid,
      company: company,
    )
    puts "            Created #{"Product".yellow} with name => #{product.name}"
  end
end
