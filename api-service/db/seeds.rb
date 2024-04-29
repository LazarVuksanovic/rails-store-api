# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Creating categories for technology products
categories = ['Computers', 'Telephones', 'Keyboards', 'Mouses', 'Headphones']

categories.each do |category_name|
  Category.create(name: category_name)
end

# Fetching category records
computer_category = Category.find_by(name: 'Computers')
telephone_category = Category.find_by(name: 'Telephones')
keyboard_category = Category.find_by(name: 'Keyboards')
mouse_category = Category.find_by(name: 'Mouses')
headphone_category = Category.find_by(name: 'Headphones')

# Creating technology-related products
computer = Product.create(name: 'Gaming Laptop', price: '2500', description: 'High-performance gaming laptop', category: computer_category)
smartphone = Product.create(name: 'Smartphone X', price: '1200', description: 'Latest Android smartphone', category: telephone_category)
keyboard = Product.create(name: 'Mechanical Keyboard', price: '100', description: 'Mechanical gaming keyboard', category: keyboard_category)
mouse = Product.create(name: 'Wireless Mouse', price: '50', description: 'Ergonomic wireless mouse', category: mouse_category)
headphones = Product.create(name: 'Noise-Canceling Headphones', price: '150', description: 'Premium noise-canceling headphones', category: headphone_category)

# Specifications
processor_spec = Specification.create(name: 'Processor')
battery_spec = Specification.create(name: 'Battery')
switch_type_spec = Specification.create(name: 'Switch Type')
dpi_spec = Specification.create(name: 'DPI')
noise_cancellation_spec = Specification.create(name: 'Noise Cancellation')

# Creating Product Specifications
ProductSpecification.create(description: 'Intel i9 Processor', product: computer, specification: processor_spec)
ProductSpecification.create(description: '5000 mAh', product: smartphone, specification: battery_spec)
ProductSpecification.create(description: 'Cherry MX', product: keyboard, specification: switch_type_spec)
ProductSpecification.create(description: '1200 DPI', product: mouse, specification: dpi_spec)
ProductSpecification.create(description: 'Active', product: headphones, specification: noise_cancellation_spec)

# Creating 5 orders
orders = [
  Order.create(status: 'Pending', name_lastname: "Lazar Vuksanovic", address: "Knez Mihailova 3", telephone: "0644029348", date: Date.today),
  Order.create(status: 'Pending', name_lastname: "Nikola Petrovic", address: "Knez Mihailova 3", telephone: "0644029348", date: Date.today),
  Order.create(status: 'Pending', name_lastname: "Martina Ivanovic", address: "Knez Mihailova 3", telephone: "0644029348", date: Date.today)
]

orders.each do |order|
  products_in_order = Product.all.sample(2)

  products_in_order.each do |product|
    r = rand(1..5)
    ProductOrder.create(
      pieces: r,
      price: product.price.to_f * r,
      product: product,
      order: order
    )
  end
end
