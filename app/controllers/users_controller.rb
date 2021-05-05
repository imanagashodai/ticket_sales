class UsersController < ApplicationController
  def edit
    @user = User.find(session[:user_id])
  end
  
  def show
    user_purchases = Purchase.where(user_id: session[:user_id]).joins(ticket: :game).order("datetime")
    @future_purchase = user_purchases.where(games: {datetime: Time.now.midnight..Float::INFINITY})
    @post_purchase = user_purchases - @future_purchase
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: "ユーザー登録しました"
    else
      if @user.errors.present?
        flash.now[:danger] = "登録失敗。"
        @user.errors.full_messages.each do |message|
          flash.now[:danger] += "#{message}。"
        end
      end
      render :new
    end
  end
  
  def destroy
    @user = User.find(session[:user_id])
    if @user.delete
      redirect_to root_path, info: "アカウント削除しました"
    else
      flash.now[:danger] = "削除失敗"
      render :show
    end
  end
  
  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to user_path, success: "アカウント更新しました"
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
