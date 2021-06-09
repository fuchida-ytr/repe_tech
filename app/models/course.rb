class Course < ApplicationRecord

    has_many :chapters, dependent: :destroy
    attachment :image

    def get_course_progress(user_id)
        # 完了したsection数 / 全section数
        all_sectons_ids = Section.where(chapter_id: chapters.pluck(:id)).pluck(:id)
        return 0 if all_sectons_ids.size == 0
        # all_sectons_ids = chapters.map{ |chapter| chapter.sections.pluck(:id) }.flatten
        comp_sections_ids = CompletedSection.where(user_id: user_id).where(section_id: all_sectons_ids).pluck(:id)
        (100 * comp_sections_ids.size / all_sectons_ids.size).round
    end

end
