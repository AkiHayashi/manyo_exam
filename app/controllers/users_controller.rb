class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :already_logged_in, only: %i[new create]
  before_action :ensure_current_user, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to user_path(@user.id)
    else 
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit %i( user_name email password password_confirmation )
  end
end
