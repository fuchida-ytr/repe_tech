class Article < ApplicationRecord
  # t.string :title
  # t.text :content
  # t.integer :category_id
  # t.integer :user_id

  # validation
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  belongs_to :category, optional: true
  has_many   :favorites, dependent: :destroy
  has_many   :favorited_users, through: :favorites, source: :user

  attr_accessor :category_name

  def self.search(keyword)
    where(["title like? OR content like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def self.sort(sort_type, category_id)
    articles = Article.includes(:category)
    if category_id
      articles = articles.where(category_id: category_id)
    end
    
    case sort_type
    when 'old'
      articles.order(updated_at: :ASC)
    when 'favorite'
      articles.sort {|a,b| b.favorites.size <=> a.favorites.size}
    else
      articles.order(updated_at: :DESC)
    end
  end
end
