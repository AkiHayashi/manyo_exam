class Admin::UsersController < ApplicationController
skip_before_action :login_required, only: %i[new create]
before_action :if_not_admin
before_action :set_user, only: %i[show edit destroy update]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to admin_users_path
    else 
      render :new
    end
  end

  def index
    @users = User.select(:id, :user_name)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      flash[:alert] = @user.errors.full_messages.join("\n")
      redirect_to admin_users_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end


  private
  def if_not_admin
    redirect_to root_path, notice: '管理者権限がありません' unless current_user.admin?
  end
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit %i( user_name email password password_confirmation admin )
  end
end
