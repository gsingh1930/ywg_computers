# Clear existing data
OrderItem.destroy_all
Order.destroy_all
Address.destroy_all
Product.destroy_all
Category.destroy_all
Province.destroy_all

# Canadian Provinces with correct tax rates
provinces = [
  { name: 'Alberta', abbreviation: 'AB', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'British Columbia', abbreviation: 'BC', gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: 'Manitoba', abbreviation: 'MB', gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: 'New Brunswick', abbreviation: 'NB', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Newfoundland and Labrador', abbreviation: 'NL', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Northwest Territories', abbreviation: 'NT', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'Nova Scotia', abbreviation: 'NS', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Nunavut', abbreviation: 'NU', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'Ontario', abbreviation: 'ON', gst: 0.0, pst: 0.0, hst: 13.0 },
  { name: 'Prince Edward Island', abbreviation: 'PE', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Quebec', abbreviation: 'QC', gst: 5.0, pst: 9.975, hst: 0.0 },
  { name: 'Saskatchewan', abbreviation: 'SK', gst: 5.0, pst: 6.0, hst: 0.0 },
  { name: 'Yukon', abbreviation: 'YT', gst: 5.0, pst: 0.0, hst: 0.0 }
]

provinces.each { |p| Province.create!(p) }
puts "Created #{Province.count} provinces"

# Categories for YWG Computers
categories = [
  { name: 'CPUs', description: 'Central Processing Units from Intel and AMD' },
  { name: 'Graphics Cards', description: 'GPUs for gaming and professional work' },
  { name: 'Displays', description: 'Monitors and screens of all sizes' },
  { name: 'Storage', description: 'SSDs, HDDs, and external storage devices' },
  { name: 'Memory', description: 'RAM modules for desktops and laptops' },
  { name: 'Accessories', description: 'Keyboards, mice, cables, and more' }
]

categories.each { |c| Category.create!(c) }
puts "Created #{Category.count} categories"

# Generate 100+ products using Faker
all_categories = Category.all

120.times do |i|
  Product.create!(
    name: "#{Faker::Computer.platform} #{Faker::Computer.type} #{i + 1}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    stock_quantity: rand(5..100),
    unit_price: rand(49.99..1999.99).round(2),
    category: all_categories.sample
  )
end

puts "Created #{Product.count} products"
puts "Seeding complete!"

# Create About and Contact pages
Page.find_or_create_by!(slug: 'about') do |page|
  page.title = 'About YWG Computers'
  page.content = "YWG Computers is Winnipeg's premier computer hardware store, serving PC builders, gamers, students, and businesses since 2019.

We offer a wide selection of CPUs, graphics cards, displays, storage devices, memory, and accessories from top brands.

Our knowledgeable staff is here to help you find the perfect components for your build or upgrade.

Visit us in Winnipeg or shop online for the best prices on computer hardware!"
end

Page.find_or_create_by!(slug: 'contact') do |page|
  page.title = 'Contact Us'
  page.content = "We'd love to hear from you!

Address: 000 Adsum Drive, Winnipeg, MB R2P R2P

Phone: 204-204-7780

Email: info@ywgcomputers.ca

Hours:
Monday - Friday: 9am - 6pm
Saturday: 10am - 5pm
Sunday: Closed

For online orders, please email orders@ywgcomputers.ca"
end

puts "Created About and Contact pages"

# Create Tags
tags = [ 'Gaming', 'Professional', 'Budget', 'High-End', 'RGB', 'Wireless', 'Portable' ]

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end

puts "Created #{Tag.count} tags"

# Assign random tags to products
Product.all.each do |product|
  product.tags << Tag.all.sample(rand(1..3))
rescue ActiveRecord::RecordInvalid
  # Skip if duplicate
end

puts "Assigned tags to products"
