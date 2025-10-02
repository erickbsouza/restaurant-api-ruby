require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:menu) { Menu.create(name: "Brazilian Dishes") }

  it "is valid with name and price" do
    item = menu.menu_items.new(name: "Baião", price: 9.0)
    expect(item).to be_valid
  end

  it "is invalid without name" do
    item = menu.menu_items.new(name: nil, price: 9.0)
    expect(item).not_to be_valid
  end

  it "is invalid with negative price" do
    item = menu.menu_items.new(name: "Tapioca", price: -1)
    expect(item).not_to be_valid
  end

  it "is invalid with zero price" do
    item = menu.menu_items.new(name: "Tapioca", price: 0)
    expect(item).not_to be_valid
  end

  it "is invalid without a menu" do
    item = MenuItem.new(name: "Baião", price: 9.0, menu: nil)
    expect(item).not_to be_valid
  end
end
