namespace :import do
  desc "Import restaurant data from a JSON file"
  task restaurants: :environment do
    file = ENV["FILE"] || "restaurant_data.json"
    importer = RestaurantDataImporter.new(file_path: file)
    result = importer.call

    puts "Import finished: #{result[:success] ? 'SUCCESS' : 'FAILURE'}"
    result[:logs].each { |log| puts log }
  end
end