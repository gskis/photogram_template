class AddCityVisitedLatitudeToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :city_visited_latitude, :float
  end
end
