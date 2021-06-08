class Section < ApplicationRecord

    belongs_to :chapter
    has_many :completed_sections, dependent: :destroy

    def completed_by?(user)
        completed_sections.where(user_id: user).exists?
    end

end
