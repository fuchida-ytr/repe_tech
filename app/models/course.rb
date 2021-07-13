class Course < ApplicationRecord
  # t.string :title
  # t.text   :caption
  # t.text   :image_id

  # validation
  # :caption, :image_idは空欄でも可
  validates :title, presence: true

  # gem 'refile'で使用
  attachment :image

  has_many :chapters, dependent: :destroy

  # コース内の全section_idを配列で返す
  def get_section_ids
    chapters.map { |chapter| chapter.sections.pluck(:id) }.flatten
  end

  # ユーザのコースの進捗率(完了したsection数 / 全section数)を返す
  def get_course_progress(user_id)
    # そのコースの全章に関連するsection_id取得
    all_section_ids = Section.where(chapter_id: chapters.pluck(:id)).pluck(:id)
    return 0 if all_section_ids.size == 0
    # 完了した全section_id取得
    comp_section_ids = CompletedSection.where(user_id: user_id).where(section_id: all_section_ids).pluck(:id)
    (comp_section_ids.size / all_section_ids.size * 100).round
  end
end
