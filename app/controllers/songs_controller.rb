class SongsController < ApplicationController
  before_action :set_song, only: [:destroy]

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
end
