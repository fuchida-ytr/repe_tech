class CoursesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  # 管理者のみ
  def index
    @courses = Course.all
    @new_course  = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "作成されました。"
    else
      flash[:alert] = "タイトルが入力されていません。"
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      flash[:notice] = "更新されました。"
    else
      flash[:alert] = "タイトルが入力されていません。"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      flash[:notice] = "削除されました。"
    else
      flash[:alert] = "削除が失敗しました。"
    end
    redirect_back(fallback_location: root_path)
  end

  # 共通
  def show 
    @course = Course.find(params[:id])
    @new_chapter = @course.chapters.build
  end

  private
  
  def course_params
    params.require(:course).permit(
      :title, :caption, :image
    )
  end
end
