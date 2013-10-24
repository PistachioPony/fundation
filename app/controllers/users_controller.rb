class UsersController < ApplicationController

  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  end

  def edit
    render :edit
  end

  def update
    if @user.destroy
      redirect_to new_user_path
    else
      render :edit
    end
  end


  def append_to_watchlist
    watchlist = current_user.watchlists.find(params[:watchlist])
    params[:companies].each do |company|
      watchlist.companies << Company.find(company.to_i)
    end

    #for each key in params (which is company id) if params[key] == 1
    #then Company.find(company.id) 
    #add users.watchlist.companies << company
    #find specific user watchlist based on submission params[:watchlist]


    redirect_to user_path
  end

  private


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end



end