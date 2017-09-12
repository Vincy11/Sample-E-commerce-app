class CommoditiesController < ApplicationController
  before_action :logged_in_user, only: [:update, :new, :show]
  before_action :correct_user,   only: [:update, :edit]
  before_action :logged_seller, only: [:new, :update, :index, :edit]
  
  def new
    @commodity = Commodity.new
    @check = Commodity.new
  end

  def create
    params[:commodity][:user_id] = session[:user_id]
   @commodity = Commodity.new(commodity_params)    #user_params is defined below
    if @commodity.save
      flash[:success] = "Data Saved Successfully!"
      render 'new'
    else
      render 'new'
    end
  end
  
  def destroy
    Commodity.find(params[:id]).destroy
    flash[:success] = "Commodity deleted"
    redirect_to commodities_path
  end

  def index
    @commodities = Commodity.all.paginate(page: params[:page])
  end

  def edit
    @commodity = Commodity.find(params[:id])
  end
  
  def update
    @commodity = Commodity.find(params[:id])
    if @commodity.update_attributes(commodity_params)
      flash[:success] = "Commodity details updated"
      redirect_to commodity_path
    else
      render 'show'
    end
  end

  def show
    @commodity = Commodity.find(params[:id])
    session[:commname] = @commodity.commname
    @distance = User.find(session[:user_id])
    @commodity1 = Commodity.where(:commname => @commodity.commname)
    @dist = Array.new
    @commodity.max = 0
    @commodity.min = 0
    @commodity1.each do |c|
      @sellername = User.find(c.user_id)
      @commodity.distance = Geocoder::Calculations.distance_between([@distance.loclat,@distance.loclong],[@sellername.loclat,@sellername.loclong])
      @dist << [@commodity.distance,@sellername.name,@sellername.id, c.price, c.id]
      if @commodity.max < c.price
        @commodity.max = c.price
      end
      if @commodity.min > c.price
        @commodity.min = c.price
      end
      if @commodity.min == 0
        @commodity.min = @commodity.max
      end
    end
    @dist.sort_by {|a|a[0]}
  end
  
  def distance_between(lat1, lon1, lat2, lon2)
    rad_per_deg = Math::PI / 180
    rm = 6371000 # Earth radius in meters
    lat1_rad, lat2_rad = lat1 * rad_per_deg, lat2 * rad_per_deg
    lon1_rad, lon2_rad = lon1 * rad_per_deg, lon2 * rad_per_deg
    a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))
    rm * c # Delta in meters
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to access"
        redirect_to login_url
      end
  end
  #Checks whether the user trying to access is a seller or a buyer
  def logged_seller
    unless logged_in_usertypeseller?
    redirect_to current_user
    flash[:danger] = "Sellers are only allowed to access commodities page."
    end
  end
  
  def correct_user
      @commodity = Commodity.find(params[:id])
      redirect_to(root_url) unless current_user_comm?(@commodity)
  end
  
  def commodity_params
      params.require(:commodity).permit(:commname, :commtype, :price, :quantity, :description, :user_id)
  end

end
