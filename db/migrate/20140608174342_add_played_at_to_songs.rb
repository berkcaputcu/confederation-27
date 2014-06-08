class AddPlayedAtToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :played_at, :datetime
  end
end
