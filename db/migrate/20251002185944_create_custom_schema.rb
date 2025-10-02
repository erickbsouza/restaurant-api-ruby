class CreateCustomSchema < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE SCHEMA IF NOT EXISTS restaurant_api"
  end

  def down
    execute "DROP SCHEMA IF EXISTS restaurant_api CASCADE"
  end
end
