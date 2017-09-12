class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :login_admin, only: [:index]
  
  def index
    @users = User.paginate(page: params[:page]) ## change from user.all to the present code for pagination
  end
  
  def new
    @user = User.new
  end
  
  def show
  @user=User.find(params[:id])
  data=0
  Commodity.all.each do |com|
    if com.user_id == @user.id
    data=data+1
    end
  end
  @user.count=data      #count is defined in user.rb as a attribute accessor and can be used as a temporary variable
  end
  
  def create
    if params[:user][:usertype] == "buyer" #Change of next 4 lines for custom coloring
      params[:user][:color] = "#5cb85c"
    elsif params[:user][:usertype] == "seller"
      params[:user][:color] = "#5bc0de"
    end
    params[:user][:commcount] = 0
    @user = User.new(user_params)    #user_params is defined below
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      log_in @user
      flash[:success] = "Welcome to the E-Commerce App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit          #action for settings page when user logges in //Next 10 lines
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
  end
  
  def login_admin
      @user = User.find(current_user)
      unless currentadmin_user?(@user)
      redirect_to @user
      flash[:danger] = "Administrator is only allowed to access users index page." 
      end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
  
  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :usertype, :loclat, :loclong, :color, :commcount) #change over here // added color option
  end
end
