class AddsController < ApplicationController
  before_action :set_playlist  
  before_action :authenticate_user!

  def index
    @add = Add.new
    @adds = @playlist.adds
  end

  def create
    @add = @playlist.adds.new(add_params)
    
    if @add.save
      redirect_to playlist_adds_path(@playlist), notice: "Added successfully."
    else
      @adds = @playlist.adds.includes(:user)
      flash.now[:alert] = "You need to enter a url for song."
      redirect_to playlist_adds_path(@playlist)
    end
  end

  def destroy
    add = Add.find(params[:id])
    if add.user_id == current_user.id
      add.destroy
      redirect_to playlist_adds_path
    end
  end

  private
  def add_params
    params.require(:add).permit(:artist, :song, :url).merge(user_id: current_user.id)
  end

  def set_playlist
    @playlist = Playlist.find(params[:playlist_id])
    @playlists = Playlist.all.order("created_at DESC")
  end
end
