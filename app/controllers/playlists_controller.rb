class PlaylistsController < ApplicationController
  def index
    @playlist = Playlist.new
    @playlists = Playlist.all.order("created_at DESC")
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlist_adds_path(@playlist), notice: "Created successfully."
    else
      flash.now[:alert] = "You need to enter Name."
      render :new
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    playlist = Playlist.find(params[:id])
    playlist.update(playlist_params)
    redirect_to playlist_adds_path(playlist)
  end

  private
  def playlist_params 
    params.require(:playlist).permit(:name, :image).merge(user_id: current_user.id)
  end
end
