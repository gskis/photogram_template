class AddLikeCountToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :likes_count, :integer
  end
end
