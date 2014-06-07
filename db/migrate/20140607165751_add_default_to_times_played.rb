class AddDefaultToTimesPlayed < ActiveRecord::Migration
  def change
    change_column_default(:songs, :times_played, 0)
  end
end
