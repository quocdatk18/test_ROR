class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(list_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = set_user
  end

  def update
    if @user.update(list_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    flash[:error] = ' No User !!!' unless @user&.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path if @user.nil?
  end

  def list_params
    params.require(:user).permit(:name, :email, :password, :address, :avatar, :phone)
  end
end
