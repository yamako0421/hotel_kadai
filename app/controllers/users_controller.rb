class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.avatar = "default_avatar.png" if @user.avatar.blank? # デフォルト画像を設定する
    if @user.save
      redirect_to root_path, success: '登録ができました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_without_password(user_params)
      redirect_to users_path, notice: 'プロフィールが更新されました。'
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy  
    sign_out(current_user)
    redirect_to root_path, notice: "サインアウトしました。"
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :full_name, :introduction)
  end
end
