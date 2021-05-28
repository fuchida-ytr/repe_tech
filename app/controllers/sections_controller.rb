class SectionsController < ApplicationController

    def new
        @chapter = Chapter.find(params[:chapter_id])
        @section = @chapter.sections.build
    end

    def create
        @chapter = Chapter.find(params[:chapter_id])
        @section = @chapter.sections.build(section_params)
        @section.save
        redirect_to course_chapter_path(@chapter.course_id, @chapter), notice: '作成しました'
    end

    def show
        @section = Section.find(params[:id])
    end

    private
  
    def section_params
        params.require(:section).permit(:title, :content)
    end

end
