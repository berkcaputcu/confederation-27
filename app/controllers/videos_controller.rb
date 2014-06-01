class VideosController < ApplicationController

  def client
    @client ||= Yourub::Client.new
  end

  def index
    @countries = client.countries
    if request.post?
      client.search(params)
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
