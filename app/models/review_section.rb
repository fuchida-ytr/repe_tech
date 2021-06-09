class ReviewSection < ApplicationRecord
  belongs_to :user
  belongs_to :section

  validates_uniqueness_of :section_id, scope: :user_id 

end