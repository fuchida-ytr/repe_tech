class Article < ApplicationRecord
  # t.string :title
  # t.text :content
  # t.integer :category_id
  # t.integer :user_id

  belongs_to :user
  belongs_to :category
  has_many   :favorites, dependent: :destroy

  attr_accessor :category_name

  def self.search(keyword)
    where(["title like? OR content like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
