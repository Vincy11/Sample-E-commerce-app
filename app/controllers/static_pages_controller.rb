class StaticPagesController < ApplicationController
  def home
  end
  
  def beverages
    @items = Commodity.where(:commtype => "beverages")
  end

  def help
  end
end
