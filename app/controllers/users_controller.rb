class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: :edit
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def new
    @user = User.new
  end
  
  def show
   @work_sum = @attendances.where.not(started_at: nil).count
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #保存成功後、ログイン
      flash[:success] = '新規登録に成功しました。'
      redirect_to @user
    else 
      render :new
    end
  end
  
  def edit
    
  end
  
  def destroy 
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
    
  end
  
  def update_basic_info
    @users = User.all
    @users.each do |users|
      if users.update_attributes(basic_info_params)
      flash[:success] = "更新しました。"
      else
      flash[:danger] = "更新は失敗しました。<br>" + users.errors.full_messages.join("<br>")
      end
    end
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:basic_time, :work_time)
    end
    
    # beforeフィルター
    # paramsハッシュからユーザーを取得する
    def set_user
      @user = User.find(params[:id])
    end
    
    # ログイン済みのユーザーか確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # システム管理権限があるユーザーか確認
    def admin_user
      redirect_to root_url unless current_user.admin?
      
    end
  
end