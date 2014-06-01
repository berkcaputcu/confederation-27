json.array!(@songs) do |song|
  json.extract! song, :id, :link
  json.url song_url(song, format: :json)
end
