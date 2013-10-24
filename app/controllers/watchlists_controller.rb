class WatchlistsController < ApplicationController

  before_action :current_user

  def show
    @watchlist = Watchlist.find(params[:id])
  end

  def new
    @watchlist = Watchlist.new
    render :new
  end

  def create
    @watchlist = Watchlist.new(watchlist_params)
    @watchlist.user_id = @current_user.id
    if @watchlist.save
      redirect_to user_path(@current_user)
    else
      render :new
    end
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:name)
  end

end