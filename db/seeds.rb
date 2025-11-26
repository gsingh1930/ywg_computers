# Clear existing data
Province.destroy_all
Category.destroy_all
Product.destroy_all

# Canadian Provinces with correct tax rates (2024)
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

provinces.each do |province|
  Province.create!(province)
end
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

categories.each do |category|
  Category.create!(category)
end
puts "Created #{Category.count} categories"

# Products for YWG Computers
products = [
  { name: 'AMD Ryzen 9 7950X', description: '16-core, 32-thread processor with 5.7GHz max boost. Perfect for gaming and content creation.', stock_quantity: 15, unit_price: 699.99, category: Category.find_by(name: 'CPUs') },
  { name: 'Intel Core i9-14900K', description: '24-core processor with up to 6.0GHz turbo. The ultimate gaming CPU.', stock_quantity: 10, unit_price: 749.99, category: Category.find_by(name: 'CPUs') },
  { name: 'AMD Ryzen 5 7600X', description: '6-core, 12-thread processor. Great value for gamers.', stock_quantity: 25, unit_price: 299.99, category: Category.find_by(name: 'CPUs') },

  { name: 'NVIDIA RTX 4090', description: '24GB GDDR6X, the most powerful consumer graphics card ever made.', stock_quantity: 5, unit_price: 2199.99, category: Category.find_by(name: 'Graphics Cards') },
  { name: 'NVIDIA RTX 4070 Ti', description: '12GB GDDR6X, excellent 1440p gaming performance.', stock_quantity: 12, unit_price: 899.99, category: Category.find_by(name: 'Graphics Cards') },
  { name: 'AMD Radeon RX 7900 XTX', description: '24GB GDDR6, AMDs flagship GPU for 4K gaming.', stock_quantity: 8, unit_price: 1149.99, category: Category.find_by(name: 'Graphics Cards') },

  { name: 'Samsung Odyssey G9', description: '49-inch curved gaming monitor, 240Hz, 1ms response time.', stock_quantity: 6, unit_price: 1499.99, category: Category.find_by(name: 'Displays') },
  { name: 'LG 27GP950-B', description: '27-inch 4K Nano IPS, 144Hz, HDMI 2.1 for console gaming.', stock_quantity: 14, unit_price: 799.99, category: Category.find_by(name: 'Displays') },
  { name: 'ASUS ProArt PA278CV', description: '27-inch 1440p professional monitor, factory calibrated.', stock_quantity: 10, unit_price: 449.99, category: Category.find_by(name: 'Displays') },

  { name: 'Samsung 990 Pro 2TB', description: 'PCIe 4.0 NVMe SSD with 7450MB/s read speeds.', stock_quantity: 30, unit_price: 249.99, category: Category.find_by(name: 'Storage') },
  { name: 'WD Black SN850X 1TB', description: 'High-performance NVMe SSD for gaming.', stock_quantity: 25, unit_price: 149.99, category: Category.find_by(name: 'Storage') },
  { name: 'Seagate Barracuda 4TB', description: 'Reliable HDD for mass storage needs.', stock_quantity: 20, unit_price: 109.99, category: Category.find_by(name: 'Storage') },

  { name: 'Corsair Vengeance DDR5 32GB', description: '32GB (2x16GB) DDR5-6000 RAM kit with RGB lighting.', stock_quantity: 18, unit_price: 179.99, category: Category.find_by(name: 'Memory') },
  { name: 'G.Skill Trident Z5 64GB', description: '64GB (2x32GB) DDR5-6400 for workstations.', stock_quantity: 8, unit_price: 349.99, category: Category.find_by(name: 'Memory') },

  { name: 'Logitech MX Master 3S', description: 'Premium wireless mouse with 8K DPI sensor.', stock_quantity: 35, unit_price: 129.99, category: Category.find_by(name: 'Accessories') },
  { name: 'Keychron Q1 Pro', description: '75% mechanical keyboard with wireless connectivity.', stock_quantity: 20, unit_price: 199.99, category: Category.find_by(name: 'Accessories') }
]

products.each do |product|
  Product.create!(product)
end
puts "Created #{Product.count} products"

puts "Seeding complete!"
