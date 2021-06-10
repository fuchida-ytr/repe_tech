class Section < ApplicationRecord

    belongs_to :chapter
    has_many :completed_sections, dependent: :destroy
    has_many :review_sections,    dependent: :destroy

    def completed_by?(user)
        completed_sections.where(user_id: user).exists?
    end

    def reviewed_by?(user)
        review_sections.where(user_id: user).exists?
    end

end
