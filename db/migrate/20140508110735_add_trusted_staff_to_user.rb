class AddTrustedStaffToUser < ActiveRecord::Migration
  def change
    add_column :users, :trusted, :boolean
    add_column :users, :staff, :boolean
  end
end
