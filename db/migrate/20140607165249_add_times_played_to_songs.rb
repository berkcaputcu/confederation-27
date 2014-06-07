class AddTimesPlayedToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :times_played, :integer
  end
end
