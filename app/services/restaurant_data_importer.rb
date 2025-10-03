# app/services/restaurant_data_importer.rb
class RestaurantDataImporter
  attr_reader :logs, :success

  def initialize(file_path: nil, json: nil)
    @file_path = file_path
    @json = json
    @logs = []
    @success = true
  end

  def call
    data = load_json

    invalid_json = handle_invalid_json(data)
    if invalid_json
      @success = false
      logs << "Invalid JSON format."
      return { success: success, logs: logs }
    end

    if empty_restaurants_data?(data)
      logs << "No restaurants found in the provided data."
      return { success: true, logs: logs }
    end
    import_restaurants(data)
    { success: success, logs: logs }
  rescue => e
    @success = false
    logs << "Unexpected error: #{e.message}"
    { success: success, logs: logs }
  end

  private

  def normalize_items(menu_data)
    menu_data["menu_items"] || menu_data["dishes"] || []
  end 

  def handle_invalid_json(data)
    return true if data.nil? || !data.is_a?(Hash)
    false
  end

  def empty_restaurants_data?(data)
    data.nil? ||
      !data.is_a?(Hash) ||
      data["restaurants"].nil? ||
      !data["restaurants"].is_a?(Array) ||
      data["restaurants"].empty?
  end
  
  def load_json
    raw = @json || File.read(@file_path)
    JSON.parse(raw)
  end

  def import_restaurants(data)
    data["restaurants"].each do |restaurant_data|
      restaurant = Restaurant.find_or_initialize_by(name: restaurant_data["name"])
      if restaurant.save
        logs << "Imported restaurant: #{restaurant.name}"
        import_menus(restaurant, restaurant_data["menus"])
      else
        logs << "Failed restaurant: #{restaurant_data["name"]} - #{restaurant.errors.full_messages.join(", ")}"
        @success = false
      end
    end
  end

  def import_menus(restaurant, menus_data)
    menus_data.each do |menu_data|
      menu = restaurant.menus.find_or_initialize_by(name: menu_data["name"])
      if menu.save
        logs << "  Imported menu: #{menu.name}"
        items_data = normalize_items(menu_data)
        import_menu_items(menu, items_data)
      else
        logs << "  Failed menu: #{menu_data["name"]} - #{menu.errors.full_messages.join(", ")}"
        @success = false
      end
    end
  end

  def import_menu_items(menu, items_data)
    items_data.each do |item_data|
      item = MenuItem.find_or_initialize_by(name: item_data["name"])

    if item.price != item_data["price"]
      logs << "    Updated price for item '#{item.name}' from #{item.price} to #{item_data["price"]}"
    end
    item.assign_attributes(price: item_data["price"])

      if item.save
        menu.menu_items << item unless menu.menu_items.exists?(item.id)
        logs << "Imported item: #{item.name}"
      else
        logs << "Failed item: #{item_data["name"]} - #{item.errors.full_messages.join(", ")}"
        @success = false
       end
    end
  end
end
