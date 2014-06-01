class VideosController < ApplicationController

  def client
    @client ||= Yourub::Client.new
  end

  def index
    if request.post?
      client.search(params.merge(:category => "music"))
      @videos = client.videos
    end
  end

  def details
    client.extended_info = true
    @video = client.search(id: params[:id])
  end

  def add_to_queue
    Song.create(youtube_id: params[:id])
    redirect_to videos_index_path
  end
end
