class ReviewSectionsController < ApplicationController
  before_action :set_section, only: %i[create destroy]
  before_action :authenticate_user!

    # 今日復習するコースとそのセクション数を表示
  def index
    @todays_review_list = ReviewSection.get_review_list(current_user.id)
    # => {course: section_num,}
  end

  def create
    @section = Section.find(params[:section_id])
    stage_1_id = ReviewStage.get_stage_1_id(current_user.id)
    @review_section = ReviewSection.create( user_id: current_user.id, 
                                            section_id: @section.id,
                                            review_stage_id: stage_1_id,
                                            next_review_date: Date.tomorrow)
  end

  def destroy
    @section = Section.find(params[:section_id])
    @review_section = ReviewSection.find_by(user_id: current_user.id, section_id: @section.id)
    @review_section.destroy
  end

  # コース別一覧
  def course_index
    @course = Course.find(params[:course_id])
    # ステージごとのセクション数を取得
    @review_list_by_stage = ReviewStage.get_review_list_by_stage(current_user.id, @course)
    # => {stage: section_num}
    # TODO: 以下、検証後削除
    ReviewSection.update_all(next_review_date: Date.current)
    @review_sections = ReviewSection.where(user_id: current_user.id)
  end

  # 特定のステージのランダムなsectionを1つ返す
  def course_show
    @course = Course.find(params[:course_id])
    # all(0), stage1, それ以外の処理
    @stage_num = params[:stage_id]
    # ステージ内の1つsectionをランダムで返す
    @todays_review_sections = ReviewSection.get_todays_review_sections(current_user.id, @course, @stage_num)
    if  @todays_review_sections
      @section = @todays_review_sections.sample.section
    else
      redirect_to course_index_review_sections_path(@course), notice: 'Clear'
    end
    # サイドバー用
    @todays_review_list = ReviewSection.get_review_list(current_user.id)
  end

  def correct
    @review_section = ReviewSection.find(params[:review_section_id])

    # 正解数+1
    correct_answers_num = @review_section.correct_answers_num + 1
    # 次のステージ、復習予定日に更新
    next_stage = ReviewStage.get_next_stage(current_user.id, @review_section.review_stage_id)
    if next_stage
      review_stage_id = next_stage.id
      next_review_date = Date.current + next_stage.after_days
    else
      # TODO: 現在のステージが最大の時の処理実装
    end
    @review_section.update(
      correct_answers_num: correct_answers_num,
      review_stage_id: review_stage_id,
      next_review_date: next_review_date
    )
    redirect_back(fallback_location: root_path)
  end

  def incorrect
    @review_section = ReviewSection.find(params[:review_section_id])
    # 不正解数+1
    incorrect_answers_num = @review_section.incorrect_answers_num + 1
    # stage1、復習予定日を明日に変更
    stage1 = ReviewStage.where(user_id: current_user.id).find_by(stage: 1)
    if stage1
      review_stage_id = stage1.id
      next_review_date = Date.tomorrow
    end
    puts Date.tomorrow
    @review_section.update(
      incorrect_answers_num: incorrect_answers_num,
      review_stage_id: review_stage_id,
      next_review_date: next_review_date
    )
    redirect_back(fallback_location: root_path)
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end
end
