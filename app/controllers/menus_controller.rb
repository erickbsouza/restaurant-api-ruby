class MenusController < ApplicationController
  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    render json: restaurant.menus.includes(:menu_items).as_json(include: :menu_items)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Restaurant not found" }, status: :not_found
  end

  def show
    menu = Menu.includes(:menu_items).find(params[:id])
    render json: menu.as_json(include: :menu_items)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Menu not found" }, status: :not_found
  end
end

