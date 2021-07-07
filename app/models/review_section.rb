class ReviewSection < ApplicationRecord
  belongs_to :user
  belongs_to :section

  validates_uniqueness_of :section_id, scope: :user_id

  # [{course: todays_section_num}]
  def self.get_todays_review_list(user_id)
    # 復習するセクションid
    # 復習予定日が今日以前のsection_idを全取得
    section_ids = where(user_id: user_id).where('next_review_date <= ?', Date.current).pluck(:section_id)

    today_sections = Section.where(id: section_ids)
    todays_review_list = {} # {course: section数,}
    today_sections.each do |section|
      todays_review_list[section.chapter.course] = todays_review_list[section.chapter.course].to_i + 1
    end
    todays_review_list
  end

  # 今日の復習するsectionをステージ別で1つランダムで返す
  def self.get_todays_review_section(user_id, course, stage)
    # 復習する全sectionを取得
    user_review_sections = where(user_id: user_id).where(section_id: course.get_section_ids).where(
      'next_review_date <= ?', Date.current
    )

    # stage == "all"のときはそのまま
    todays_review_sections = user_review_sections

    if stage == '1'
      # stage1は,review_stage_idがnil
      todays_review_sections = user_review_sections.where(review_stage_id: nil)
    elsif stage != 'all'
      # ユーザーが持つstageからstage名を検索してidを取得
      current_user = User.find(user_id)
      stage_id = current_user.review_stages.find_by(stage: stage).id
      todays_review_sections = user_review_sections.where(review_stage_id: stage_id)
    end

    return nil if todays_review_sections.empty?

    # ランダムで1つsectionを返す
    todays_review_sections.sample.section
  end
end
