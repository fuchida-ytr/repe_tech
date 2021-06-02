class ChaptersController < ApplicationController

    def create
        @chapter = Course.find(params[:course_id]).chapters.build(chapter_params)
        @chapter.save
        redirect_back(fallback_location: root_path)
    end

    def show
        @chapter = Chapter.find(params[:id])
    end

    def update
        @chapter = Chapter.find(params[:id])

        if @chapter.update(chapter_params)
            redirect_to course_chapter_path(@chapter.course, @chapter), notice: '更新しました'
        else
            render 'show'
        end
    end

    def destroy
        @chapter = Chapter.find(params[:id])
        @chapter.destroy
        redirect_to course_path(@chapter.course_id), notice: '削除しました'
    end

    private
  
    def chapter_params
        params.require(:chapter).permit(:title)
    end

end
