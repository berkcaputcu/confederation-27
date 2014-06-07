class VideosController < ApplicationController

  def client
    @client ||= Yourub::Client.new
  end

  def index
    @queued = Song.all.select(&:queued?)
    if params[:query]
      client.search(params.merge(:category => "music"))
      @videos = client.videos
    end
  end

  def add_to_queue
    Song.create(youtube_id: params[:youtube_id], title: params[:title])
    redirect_to videos_index_path
  end
end
