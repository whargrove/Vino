class AddStatusToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :published
    add_column :posts, :status, :integer, default: 0
  end
end
