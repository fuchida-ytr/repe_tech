class CoursesController < ApplicationController

    def index
        @course = Course.new
        @courses = Course.all
    end

    def create
        @course = Course.new(course_params)
        @course.save
        redirect_to courses_path, success: '投稿に成功しました！'
    end

    private
  
    def course_params
      params.require(:course).permit(
        :title, :caption
      )
    end

end
