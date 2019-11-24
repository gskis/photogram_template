class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :country_name
      t.string :image
      t.integer :owner_id
      t.string :city_visited
      t.integer :rating
      t.string :must_do

      t.timestamps
    end
  end
end
