class Displayitem < ActiveRecord::Base
  def create
    session[:quantity] = displayitem[:quantity]
  end
end
