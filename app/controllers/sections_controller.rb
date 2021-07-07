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

  def edit
    @chapter = Chapter.find(params[:chapter_id])
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      redirect_to chapter_section_path(@section.chapter_id, @section), notice: '更新しました'
    else
      render 'show'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to course_chapter_path(@section.chapter.course_id, @section.chapter), notice: '削除しました'
  end

  def complete
    @section = Section.find(params[:section_id])
    @complete = CompletedSection.create(user_id: current_user.id, section_id: @section.id)
  end

  def incomplete
    @section = Section.find(params[:section_id])
    @complete = CompletedSection.find_by(user_id: current_user.id, section_id: @section.id)
    @complete.destroy
  end

  private

  def section_params
    params.require(:section).permit(:title, :content)
  end
end
