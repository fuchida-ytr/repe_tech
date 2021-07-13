class Chapter < ApplicationRecord
  # t.string  :title
  # t.integer :course_id

  # validation
  validates :title, presence: true

  belongs_to :course
  has_many :sections, dependent: :destroy

  # chapterの進捗率(完了したsection数 / 全section数)を返す
  def get_chapter_progress(user_id)
    # その章に関連する全section_id取得
    all_sectons_ids = sections.pluck(:id)
    return 0 if all_sectons_ids.size == 0

    # 完了した全section_id取得
    comp_sections_ids = CompletedSection.where(user_id: user_id).where(section_id: all_sectons_ids).pluck(:id)
    (comp_sections_ids.size / all_sectons_ids.size * 100).round
  end
end
