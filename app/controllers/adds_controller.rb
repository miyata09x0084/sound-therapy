class AddsController < ApplicationController
  before_action :set_playlist  

  def index
    @add = Add.new
    @adds = @playlist.adds
  end

  def create
    @add = @playlist.adds.new(add_params)
    
    if @add.save!
      redirect_to playlist_adds_path(@playlist), notice: "Song was added"
    else
      @adds = @playlist.adds.includes(:user)
      flash.now[:alert] = "enter a url for song"
      render :create
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
  end
end
