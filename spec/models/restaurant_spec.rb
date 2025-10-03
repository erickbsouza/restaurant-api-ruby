require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "is valid with a name" do
    restaurant = Restaurant.new(name: "Ordones")
    expect(restaurant).to be_valid
  end

  it "is invalid without a name" do
    restaurant = Restaurant.new(name: nil)
    expect(restaurant).not_to be_valid
  end

  it "has many menus" do
    restaurant = Restaurant.create(name: "Ordones")
    menu1 = Menu.create(name: "Brazilian Dishes", restaurant: restaurant)
    menu2 = Menu.create(name: "Italian Dishes", restaurant: restaurant)
    expect(restaurant.menus).to include(menu1, menu2)
  end

  it "destroys associated menus when deleted" do
    restaurant = Restaurant.create(name: "Ordones")
    menu = Menu.create(name: "Brazilian Dishes", restaurant: restaurant)
    expect { restaurant.destroy }.to change { Menu.count }.by(-1)
  end

  it "destroys associated menus when deleted but not menu items associated with those menus" do
    restaurant = Restaurant.create(name: "Ordones")
    menu = Menu.create(name: "Brazilian Dishes", restaurant: restaurant)
    menu_item = MenuItem.create(name: "Feijoada", price: 25.0)
    menu.menu_items << menu_item
    expect { restaurant.destroy }.to change { Menu.count }.by(-1)
    expect(MenuItem.exists?(menu_item.id)).to be true
  end
end
