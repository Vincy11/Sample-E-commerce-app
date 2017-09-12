class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:update, :new, :show, :index]
  before_action :correct_user, only: [:update, :new, :show, :index]
  
  def index
    @utype = User.new
    @utype.utype = params[:usertype]
    if session[:usertype] == "buyer"
      if @utype.utype == "seller"
      @messages = Message.where(:usertype => @utype.utype , :user_id => session[:user_id]).paginate(page: params[:page], per_page: 5)
      else
      @messages = Message.where(:usertype => @utype.utype , :fromid => session[:user_id]).paginate(page: params[:page], per_page: 5)
      end
    else
      @messages = Message.where(:usertype => @utype.utype , :user_id => session[:user_id]).paginate(page: params[:page], per_page: 5)
    end
  end

  def edit
  end

  def new
    @message = Message.new
    @message.status = false
    if session[:commname] != nil && session[:usertype] == "buyer"
      @message.status = true
      @message.uid = params[:id]
    else
      @message.uid = params[:rid]
    end
  end
  
  def create
    params[:message][:fromid] = session[:user_id]
    @usert = User.find(session[:user_id])
    params[:message][:usertype] = @usert.usertype
    @message = Message.new(message_params)    #message_params are defined below
    if @message.save
      flash[:success] = "Message sent Successfully!"
      redirect_to displayitems_path
    else
      render 'new'
    end
    session[:commname]=nil
  end

  def show
    @messages = Message.find(params[:id])
  end
  
  def correct_user
      @user = User.find(session[:user_id])
      redirect_to(root_url) unless current_user?(@user)
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to access"
        redirect_to login_url
      end
  end
  
  def message_params
      params.require(:message).permit(:email, :usertype, :message, :user_id, :fromid)
  end
end
