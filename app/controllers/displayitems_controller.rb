class DisplayitemsController < ApplicationController
  def edit
  end
  
  def update
  end

  def index
    @items = Commodity.all
  end
  
  def redict
  end

  def new
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
end
