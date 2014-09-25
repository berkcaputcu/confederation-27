class SongsController < ApplicationController
  before_action :set_song, only: [:destroy]

  def index
    @fav_songs = Song.order('times_played DESC').first(10)
    @song_history = Song.order('played_at DESC').first(10)
  end

  def search
    @queued = Song.all.select(&:queued?)
    if params[:query]
      client.search(params.merge(:category => "music"))
      @videos = client.videos
    end
  end

  def next
    trigger_pusher('next')
    redirect_to search_songs_path
  end

  def create
    @song = Song.create_with(title: song_params["title"]).find_or_create_by(youtube_id: song_params["youtube_id"])
    @song.reset
    trigger_pusher('new')
    redirect_to search_songs_path
  end

  def play
    @current = Song.where(state: 'queued').order('updated_at DESC').last
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

  def redirect_to_jukapp
    redirect_to "http://www.jukapp.io/rooms/4/join"
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

  def trigger_pusher(action)
    Pusher.url = "http://#{ENV['PUSHER_KEY']}:#{ENV['PUSHER_SECRET']}@api.pusherapp.com/apps/#{ENV['PUSHER_ID']}"
    Pusher['songs'].trigger(action, {})
  end
end
