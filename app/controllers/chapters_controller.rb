class ChaptersController < ApplicationController

    def create
        @chapter = Course.find(params[:course_id]).chapters.build(chapter_params)
        @chapter.save
        redirect_back(fallback_location: root_path)
    end

    def show
        @chapter = Chapter.find(params[:id])
    end

    private
  
    def chapter_params
        params.require(:chapter).permit(:title)
    end

end
