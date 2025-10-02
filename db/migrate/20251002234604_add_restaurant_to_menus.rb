class AddRestaurantToMenus < ActiveRecord::Migration[8.0]
  def up
    add_reference :menus, :restaurant, null: true, foreign_key: true

    # Assign a default restaurant to existing menus (create one if needed)
    default_restaurant = Restaurant.first || Restaurant.create!(name: "Default Restaurant")
    Menu.where(restaurant_id: nil).update_all(restaurant_id: default_restaurant.id)

    change_column_null :menus, :restaurant_id, false
  end

  def down
    remove_reference :menus, :restaurant, foreign_key: true
  end
end
