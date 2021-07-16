class Article < ApplicationRecord
  # t.string :title
  # t.text :content
  # t.integer :category_id
  # t.integer :user_id

  belongs_to :user
  belongs_to :category
  has_many   :favorites, dependent: :destroy
  has_many   :favorited_users, through: :favorites, source: :user

  attr_accessor :category_name

  def self.search(keyword)
    where(["title like? OR content like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def self.sort(sort_type)
    articles = Article.includes(:category)
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
