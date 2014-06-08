class AddYoutubeIdIndexToSongs < ActiveRecord::Migration
  def change
    add_index(:songs, :youtube_id)
  end
end
