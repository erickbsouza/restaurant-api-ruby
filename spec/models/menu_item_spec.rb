require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "is valid with name and positive price" do
    item = MenuItem.new(name: "Baião", price: 9.0)
    expect(item).to be_valid
  end

  it "is invalid without a name" do
    item = MenuItem.new(name: nil, price: 9.0)
    expect(item).not_to be_valid
  end

  it "is invalid with non-positive price" do
    item = MenuItem.new(name: "Baião", price: 0)
    expect(item).not_to be_valid
  end

  it "is invalid with negative price" do
    item = MenuItem.new(name: "Baião", price: -50)
    expect(item).not_to be_valid
  end

  it "does not allow duplicate names" do
    MenuItem.create!(name: "Acarajé", price: 12.0)
    duplicate = MenuItem.new(name: "Acarajé", price: 15.0)
    expect(duplicate).not_to be_valid
  end

  it "can belong to multiple menus" do
    restaurant = Restaurant.create!(name: "Casa do Nordeste")
    menu1 = restaurant.menus.create!(name: "Lunch")
    menu2 = restaurant.menus.create!(name: "Dinner")

    item = MenuItem.create!(name: "Tapioca", price: 7.0)

    menu1.menu_items << item
    menu2.menu_items << item

    expect(item.menus.count).to eq(2)
  end

  it "is invalid with a name shorter than 2 characters" do
    item = MenuItem.new(name: "A", price: 10.0)
    expect(item).not_to be_valid
  end

  it "is invalid with a name longer than 100 characters" do
    long_name = "A" * 101
    item = MenuItem.new(name: long_name, price: 10.0)
    expect(item).not_to be_valid
  end
end

