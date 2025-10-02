require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with a name" do
    menu = Menu.new(name: "Brazilian Dishes")
    expect(menu).to be_valid
  end

  it "is invalid without a name" do
    menu = Menu.new(name: nil)
    expect(menu).not_to be_valid
  end

  it "on destroy also destroys associated menu items" do
    menu = Menu.create(name: "Brazilian Dishes")
    menu.menu_items.create(name: "Baião", price: 9.0)
    expect { menu.destroy }.to change { MenuItem.count }.by(-1)
  end

  it "has many menu items" do
    menu = Menu.create(name: "Brazilian Dishes")
    item1 = menu.menu_items.create(name: "Baião", price: 9.0)
    item2 = menu.menu_items.create(name: "Tapioca", price: 7.0)
    expect(menu.menu_items).to include(item1, item2)
  end
end
