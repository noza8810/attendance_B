class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def new
    @user = User.new
  end
  
  def show
   @work_sum = @attendances.where.not(started_at: nil).count
  end
  
  def index
    @users = User.paginate(page: params[:page])
    @users = @users.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
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
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザーの情報を更新しました。"
      redirect_to user_url
    else
      render :edit
    end
    
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
end
