class ReviewSection < ApplicationRecord
  # t.date    :next_review_date
  # t.integer :correct_answers_num,   default: 0
  # t.integer :incorrect_answers_num, default: 0
  # t.integer :review_stage_id
  # t.references :user, null: false, foreign_key: true
  # t.references :section, null: false, foreign_key: true

  belongs_to :user
  belongs_to :section

  validates_uniqueness_of :section_id, scope: :user_id

  # [{course: todays_section_num}] 0も含む
  def self.get_review_list(user_id)
    # 復習する全セクションid取得
    section_ids = where(user_id: user_id).pluck(:section_id)
    # 復習予定日が今日以前のsection_idを全取得
    todays_section_ids = where(user_id: user_id).
                         where('next_review_date <= ?', Date.current).
                         pluck(:section_id)
    todays_review_list = {} # {course: section数,}
    # 全セクションidからセクションを取得しコースを取得
    Section.where(id: section_ids).each do |section|
      # 今日復習するセクションかどうか
      is_todays_seciotn = todays_section_ids.include?(section.id)
      course = section.chapter.course
      if todays_review_list.key?(course) && is_todays_seciotn
        section_num = todays_review_list[course].to_i + 1
      elsif is_todays_seciotn
        section_num = 1
      else
        section_num = 0
      end
      todays_review_list.store(course, section_num)
    end
    todays_review_list
  end

  # 今日の復習する指定されたステージの全sectionを返す
  def self.get_todays_review_sections(user_id, course, stage_num)
    # 復習する全sectionを取得
    user_review_sections = where(user_id: user_id).
                           where(section_id: course.get_section_ids).
                           where('next_review_date <= ?', Date.current)

    # ユーザーが持つstageからstage名を検索してidを取得
    current_user = User.find(user_id)
    stage_id = current_user.review_stages.find_by(stage: stage_num).id
    todays_review_sections = user_review_sections.where(review_stage_id: stage_id)
    return nil if todays_review_sections.empty?
    todays_review_sections
    # TODO: stageがallのときの処理
  end
end
