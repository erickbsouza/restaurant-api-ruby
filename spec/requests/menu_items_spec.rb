require 'rails_helper'

RSpec.describe MenuItemsController, type: :controller do
    let(:restaurant) { Restaurant.create!(name: "Ordones") }
    let(:menu) { Menu.create!(name: "Brazilian Dishes", restaurant: restaurant) }
    let!(:menu_item) { menu.menu_items.create!(name: "Baião", price: 9.0) }

    describe "GET #index" do
        it "returns all menu items for the menu" do
            get :index, params: { menu_id: menu.id }
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).first["name"]).to eq("Baião")
        end
    end

    describe "GET #show" do
        context "when menu item exists" do
            it "returns the menu item" do
                get :show, params: { id: menu_item.id }
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body)["name"]).to eq("Baião")
            end
        end

        context "when menu item does not exist" do
            it "returns not found" do
                get :show, params: { id: 9999 }
                expect(response).to have_http_status(:not_found)
                expect(JSON.parse(response.body)["error"]).to eq("MenuItem not found")
            end
        end
    end
end
