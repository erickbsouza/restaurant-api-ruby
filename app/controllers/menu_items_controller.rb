class MenuItemsController < ApplicationController
    before_action :set_menu
    def index
        render json: @menu.menu_items
    end

    def show
        begin
            item = @menu.menu_items.find(params[:id])
            render json: item
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'MenuItem not found' }, status: :not_found
        end
    end

    private

    def set_menu
        @menu = Menu.find(params[:menu_id])
    end
end
