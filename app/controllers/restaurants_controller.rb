class RestaurantsController < ApplicationController
  def index
    render json: Restaurant.includes(menus: :menu_items).all.as_json(include: { menus: { include: :menu_items } })
  end

  def show
    restaurant = Restaurant.find(params[:id])
    render json: restaurant.as_json(include: { menus: { include: :menu_items } })
  end
end
