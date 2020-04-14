class AttendancesController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @attendance =Attendance.find(params[:id])
    #出勤登録が未登録であることを判定
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info]= "おはようございます！"
      else
        flash[:danger] = "勤怠登録に失敗しました。やり直してください"
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info]= "お疲れさまです。"
      else 
        flash[:danger] = "勤怠登録に失敗しました。やり直してください"
      end
    end
    redirect_to @user
  end
end
