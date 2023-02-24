class SubsController < ApplicationController

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
  end

  def update
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  private
  def sub_params
  params.require(:sub).permit(:title,:description,:moderator_id)
  end

end
