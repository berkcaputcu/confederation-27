class RemoveLinkFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :link, :string
  end
end
