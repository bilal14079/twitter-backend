class ChangeColumnsOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :tweets_count, :integer, default: 0
    change_column :users, :friends_count, :integer, default: 0
  end
end
