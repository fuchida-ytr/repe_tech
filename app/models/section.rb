class Section < ApplicationRecord
  # t.string  :title
  # t.text    :content
  # t.integer :chapter_id

  belongs_to :chapter
  has_many :completed_sections, dependent: :destroy
  has_many :review_sections,    dependent: :destroy

  def self.search(keyword)
    where(["title like? OR content like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # 完了済みかチェック
  def completed_by?(user)
    completed_sections.where(user_id: user).exists?
  end

  # 復習するかチェック
  def reviewed_by?(user)
    review_sections.where(user_id: user).exists?
  end
end
