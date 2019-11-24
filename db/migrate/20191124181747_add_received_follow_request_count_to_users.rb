class AddReceivedFollowRequestCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :received_follow_requests_count, :integer
  end
end
