require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let(:restaurant) { Restaurant.create!(name: "Ordones") }
  let!(:menu) { Menu.create!(name: "Brazilian Dishes", restaurant: restaurant) }
  let!(:menu_item) { menu.menu_items.create!(name: "Baião", price: 9.0) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns all menus with their menu items" do
      get :index
      json = JSON.parse(response.body)
      expect(json.first["name"]).to eq("Brazilian Dishes")
      expect(json.first["menu_items"].first["name"]).to eq("Baião")
    end
  end

  describe "GET #show" do
    context "when menu exists" do
      it "returns the menu with its menu items" do
        get :show, params: { id: menu.id }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Brazilian Dishes")
        expect(json["menu_items"].first["name"]).to eq("Baião")
      end

      it "returns a successful response" do
        get :show, params: { id: menu.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when menu does not exist" do
      it "returns not found status and error message" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Menu not found")
      end
    end
  end
end

