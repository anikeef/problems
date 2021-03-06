class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :logged_out_user, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Please check your email to activate the account"
      @user.send_activation_email
      redirect_to root_url
    else
      render "new"
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @problems = @user.problems.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
