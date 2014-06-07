class SongsController < ApplicationController
  before_action :set_song, only: [:destroy]

  def search
    @queued = Song.all.select(&:queued?)
    if params[:query]
      client.search(params.merge(:category => "music"))
      @videos = client.videos
    end
  end

  def create
    Song.create(song_params)
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
