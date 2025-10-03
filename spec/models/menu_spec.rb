require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with a name" do
    restaurant = Restaurant.create(name:"Ordones")
    menu = Menu.new(name: "Brazilian Dishes", restaurant: restaurant)
    expect(menu).to be_valid
  end

  it "is invalid without a name" do
    restaurant = Restaurant.create(name:"Robert's Steakhouse")
    menu = Menu.new(name: nil, restaurant: restaurant)
    expect(menu).not_to be_valid
  end

  it "on destroy leave menu_items without destroyed menu" do
    restaurant = Restaurant.create(name:"Ordones")
    menu = Menu.create(name: "Brazilian Dishes", restaurant: restaurant)
    menu_item = menu.menu_items.create(name: "Baião", price: 9.0)
    expect { menu.destroy }.not_to change { MenuItem.count }
    expect(menu_item.reload.menus).not_to include(menu)
  end

  it "has many menu items" do
    restaurant = Restaurant.create(name:"Ordones")
    menu = Menu.create(name: "Brazilian Dishes", restaurant: restaurant)
    item1 = menu.menu_items.create(name: "Baião", price: 9.0)
    item2 = menu.menu_items.create(name: "Tapioca", price: 7.0)
    expect(menu.menu_items).to include(item1, item2)
  end
end
