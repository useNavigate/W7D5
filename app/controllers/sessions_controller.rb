class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid credentials. Please try again cuh"]
      @username = params[:user][:username] # params is what we put in the form
      render :new
    end

  end

  def destroy
    logout!
    redirect_to new_session_url
  end


end