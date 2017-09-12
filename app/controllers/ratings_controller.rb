class RatingsController < ApplicationController
  before_action :logged_in_user, only: [:new , :create, :show]
  before_action :correct_user,   only: [:show]
  before_action :logged_buyer, only: [:new, :create]
  before_action :logged_seller, only: [:show]
  
  def index
  end

  def new
    @rating = Rating.new
    @rating.id = params[:id]
    #@sellerdetails = User.where(:usertype => "seller")
  end
  
  def create
    if Rating.exists?(:user_id => params[:rating][:user_id])
      @rating = Rating.find_by(:user_id => params[:rating][:user_id])
    @rating.rating = @rating.rating * @rating.ratingcount
    @rating.rating = @rating.rating + params[:rating][:rating].to_f
    @rating.ratingcount = @rating.ratingcount + 1
    @rating.rating = @rating.rating / @rating.ratingcount
    params[:rating][:rating] = @rating.rating
    params[:rating][:ratingcount] = @rating.ratingcount
    if @rating.update_attributes(rating_params)
      flash[:success] = "Rating details updated"
      redirect_to displayitems_path
    else
      render 'new'
    end
    elsif
    params[:rating][:ratingcount] = 1
    @rating = Rating.new(rating_params)
    if @rating.save
      flash[:success] = "Rating details updated"
      redirect_to displayitems_path
    else
      render 'new'
    end
    end
  end

  def show
    if Rating.exists?(:user_id => params[:id])
    @rating = Rating.find_by(:user_id => params[:id])
    elsif
    flash[:danger] = "No Rating available for your profile right now!"
    redirect_to root_url
    end
  end

  def edit
  end
  
  def rating_params
      params.require(:rating).permit(:rating, :ratingcount, :user_id)
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
  end
  
  def logged_buyer
    unless logged_in_usertypebuyer?
    redirect_to current_user
    flash[:danger] = "Buyers are only allowed to access ratings page."
    end
  end
  
  def logged_seller
    unless logged_in_usertypeseller?
    redirect_to current_user
    flash[:danger] = "Sellers are only allowed to access commodities page."
    end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
end
