class AddLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :link, :boolean, null: false, default: false
    add_column :posts, :link_url, :string
  end
end
