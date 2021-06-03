class Course < ApplicationRecord

    has_many :chapters, dependent: :destroy
    attachment :image

end
