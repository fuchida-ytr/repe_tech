class CoursesController < ApplicationController

    def index
        @course = Course.new
        @courses = Course.all
    end

    def create
        @course = Course.new(course_params)
        @course.save
        redirect_to courses_path, notice: '投稿に成功しました'
    end

    def show
        @course = Course.find(params[:id])
    end

    def edit
        @course = Course.find(params[:id])
    end

    def update
        @course = Course.find(params[:id])
        if @course.update(course_params)
            redirect_to course_path(@course), notice: '更新しました'
        else
            render 'show'
        end
    end

    def destroy
        @course = Course.find(params[:id])
        @course.destroy
        redirect_to courses_path, notice: '削除しました'
    end

    private
  
    def course_params
      params.require(:course).permit(
        :title, :caption
      )
    end

end
