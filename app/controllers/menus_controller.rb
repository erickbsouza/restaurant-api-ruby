class MenusController < ApplicationController
    def index
        render json: Menu.includes(:menu_items).all.as_json(include: :menu_items)
    end

    def show
        begin
            menu = Menu.find(params[:id])
            render json: menu.as_json(include: :menu_items)
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Menu not found" }, status: :not_found
        end
    end
end
