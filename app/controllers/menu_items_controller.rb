class MenuItemsController < ApplicationController
  before_action :set_menu, only: [:index]
  before_action :set_menu_item, only: [:show]

  # GET /menus/:menu_id/menu_items
  def index
    render json: @menu.menu_items
  end

  # GET /menu_items/:id
  def show
    if @menu_item
      render json: @menu_item
    else
      render json: { error: "MenuItem not found" }, status: :not_found
    end
  end

  private

  def set_menu
    @menu = Menu.find(params[:menu_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Menu not found" }, status: :not_found
  end

  def set_menu_item
    @menu_item = MenuItem.find_by(id: params[:id])
  end
end
