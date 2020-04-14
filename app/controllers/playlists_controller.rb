class PlaylistsController < ApplicationController
  def index
    return nil if params[:keyword] == ""
    @playlistsSearch = Playlist.where(['name LIKE ?', "%#{params[:keyword]}%"] ).limit(10)

    # ajax通信の記述:dataTypeの種類に応じて参照するファイルを切り替える
    respond_to do |format|
        format.html
        format.json
        # ajax記述には、dataType: 'json' と書かれているので
        # index.json.jbuilderファイルが読み込まれる
    end

    @playlist = Playlist.new
    @playlists = Playlist.all.order("created_at DESC")
    @playlists_random = Playlist.all.order("RAND()")
  end

  def new
    if user_signed_in?
      @playlist = Playlist.new
    else
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
    end
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlist_adds_path(@playlist), notice: "Created successfully."
    else
      flash.now[:alert] = "You need to enter Place."
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
    params.require(:playlist).permit(:name, :image, :feeling).merge(user_id: current_user.id)
  end
end
