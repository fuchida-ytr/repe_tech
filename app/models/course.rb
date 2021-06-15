class Course < ApplicationRecord

    has_many :chapters, dependent: :destroy
    attachment :image

    # コース内の全section_idを配列で返す
    def get_section_ids
        self.chapters.map{ |chapter| chapter.sections.pluck(:id)}.flatten
    end
    
    # ユーザーのコースの進捗率を返す
    def get_course_progress(user_id)
        # 完了したsection数 / 全section数
        all_section_ids = Section.where(chapter_id: chapters.pluck(:id)).pluck(:id)
        return 0 if all_section_ids.size == 0
        # all_section_ids = chapters.map{ |chapter| chapter.sections.pluck(:id) }.flatten
        comp_section_ids = CompletedSection.where(user_id: user_id).where(section_id: all_section_ids).pluck(:id)
        (100 * comp_section_ids.size / all_section_ids.size).round
    end


end
