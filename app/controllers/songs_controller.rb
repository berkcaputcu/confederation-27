class SongsController < ApplicationController
  before_action :set_song, only: [:destroy]

  def index
    @songs = Song.order('times_played DESC').first(5)
  end

  def search
    @queued = Song.all.select(&:queued?)
    if params[:query]
      client.search(params.merge(:category => "music"))
      @videos = client.videos
    end
  end

  def next
    Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_ID']}"
    Pusher['songs'].trigger('next', {})
    redirect_to search_songs_path
  end

  def create
    @song = Song.create_with(title: song_params["title"]).find_or_create_by(youtube_id: song_params["youtube_id"])
    @song.reset
    redirect_to search_songs_path
  end

  def play
    @current = Song.all.select(&:queued?).first
    @current.play unless @current.nil?
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private
  def set_song
    @song = Song.find(params[:id])
  end

  def client
    @client ||= Yourub::Client.new
  end

  def song_params
    params.require(:song).permit(:youtube_id, :title)
  end
end
