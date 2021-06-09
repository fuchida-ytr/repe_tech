class Chapter < ApplicationRecord

    belongs_to :course

    has_many :sections, dependent: :destroy

    def get_chapter_progress(user_id)
        # 完了したsection数 / 全section数
        all_sectons_ids = sections.pluck(:id)
        return 0 if all_sectons_ids.size == 0
        comp_sections_ids = CompletedSection.where(user_id: user_id).where(section_id: all_sectons_ids).pluck(:id)
        (100 * comp_sections_ids.size / all_sectons_ids.size).round
    end

end
