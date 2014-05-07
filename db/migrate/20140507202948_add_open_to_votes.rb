class AddOpenToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :open, :boolean
  end
end
