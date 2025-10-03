require "rails_helper"

RSpec.describe RestaurantDataImporter do
  let(:json) do
    {
      "restaurants" => [
        {
          "name" => "Chico's Crab Shack",
          "menus" => [
            {
              "name" => "Dinner",
              "items" => [
                { "name" => "Boiled Crab", "price" => 15.0 }
              ]
            }
          ]
        }
      ]
    }.to_json
  end

  it "imports restaurants, menus and items successfully" do
    importer = described_class.new(json: json)
    result = importer.call

    expect(result[:success]).to be true
    expect(Restaurant.count).to eq 1
    expect(Menu.count).to eq 1
    expect(MenuItem.count).to eq 1
    expect(result[:logs].join).to include("Imported restaurant")
  end

  it "handles empty JSON gracefully" do
    importer = described_class.new(json: "{}")
    result = importer.call
    expect(result[:success]).to be true
    expect(result[:logs].join).to include("No restaurants found")
  end

  it "handles invalid JSON format" do
    importer = described_class.new(json: "invalid json")
    result = importer.call
    expect(result[:success]).to be false
    expect(result[:logs].join).to include("Unexpected error: unexpected character: 'invalid' at line 1 column 1")
  end

  it "skips duplicate menu items" do
    duplicate_item_json = {
      "restaurants" => [
        {
          "name" => "Chico's Crab Shack",
          "menus" => [
            {
              "name" => "Dinner",
              "items" => [
                { "name" => "Boiled Crab", "price" => 15.0 },
                { "name" => "Boiled Crab", "price" => 15.0 }
              ]
            }
          ]
        }
      ]
    }.to_json

    importer = described_class.new(json: duplicate_item_json)
    result = importer.call
    expect(result[:success]).to be true
    expect(MenuItem.count).to eq 1
    expect(result[:logs].join).to include("Skipped existing item")
  end

  it "logs errors for invalid data" do
    bad_json = { "restaurants" => [{ "name" => "" }] }.to_json
    importer = described_class.new(json: bad_json)
    result = importer.call

    expect(result[:success]).to be false
    expect(result[:logs].join).to include("Failed restaurant")
  end
end