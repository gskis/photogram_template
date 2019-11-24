class AddCityVisitedFormattedAddressToTrip < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :city_visited_formatted_address, :string
  end
end
