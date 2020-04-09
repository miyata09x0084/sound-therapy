json.array! @playlistsSearch do |playlist|
  json.id  playlist.id
  json.name  playlist.name
  json.image  playlist.image
end