class AddCommentCountToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :comments_count, :integer
  end
end
