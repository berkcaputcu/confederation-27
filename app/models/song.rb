class Song < ActiveRecord::Base
  state_machine :state, :initial => :queued do
    event :play do
      transition :queued => :played
    end
  end

  def self.calculate_times_played
    songs = Song.all
    (songs.group_by {|s| s.youtube_id}).each do |id, songs|
      times_played = songs.size
      song_to_keep = songs.pop
      song_to_keep.update_attributes(times_played: times_played)
      songs.each {|s| s.destroy}
    end
  end
end
