MenuItem.delete_all
Menu.delete_all
Restaurant.delete_all

brazilian_restaurant = Restaurant.create!(name: "Brazilian Delights")
nordestine_restaurant = Restaurant.create!(name: "Nordestine Flavors")

brazilian_menu = brazilian_restaurant.menus.create!(name: "Typical Brazilian Foods", description: "Traditional dishes from Brazil")
brazilian_menu.menu_items.create!([
  { name: "Feijoada", price: 25.0 },
  { name: "Pão de Queijo", price: 8.0 },
  { name: "Brigadeiro", price: 5.0 }
])

nordestine_menu = nordestine_restaurant.menus.create!(name: "Typical Northeastern Foods", description: "Traditional dishes from the Northeast of Brazil")
nordestine_menu.menu_items.create!([
  { name: "Baião de Dois", price: 20.0 },
  { name: "Acarajé", price: 10.0 },
  { name: "Carne de Sol with Macaxeira", price: 30.0 }
])

puts "Seeding complete! #{Restaurant.count} restaurants, #{Menu.count} menus and #{MenuItem.count} items created."