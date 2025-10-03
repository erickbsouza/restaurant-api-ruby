class ImportsController < ApplicationController
  def create
    begin
      data = request.raw_post
      importer = RestaurantDataImporter.new(json: data)
      result = importer.call

      if result[:success]
        render json: result, status: :ok
      else
        render json: result, status: :unprocessable_entity
      end
    rescue JSON::ParserError => e
      render json: { success: false, logs: ["Invalid JSON: #{e.message}"] }, status: :unprocessable_entity
    rescue => e
      render json: { success: false, logs: ["Unexpected error: #{e.message}"] }, status: :internal_server_error
    end
  end
end