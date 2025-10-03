require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/restaurants"
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /show" do
    it "returns http success" do
      restaurant = Restaurant.create(name: "Ordones")
      get "/restaurants/#{restaurant.id}"
      expect(response).to have_http_status(:success)
    end

    it "returns http not found for non-existing restaurant" do
      get "/restaurants/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
