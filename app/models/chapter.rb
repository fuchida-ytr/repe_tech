class Chapter < ApplicationRecord

    belongs_to :course

    has_many :sections, dependent: :destroy

end
