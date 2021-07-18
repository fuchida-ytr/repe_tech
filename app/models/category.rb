class Category < ApplicationRecord
  # t.string :name
  # validation
  validates :name, presence: true
  
  has_many :articles

  # カテゴリー名でidを取得
  def self.get_id(name, create_flag)
    category = Category.find_by(name: name)
    if category.nil? && create_flag
      category = Category.new(name: name)
      category.save
    end
    category.id
  end
 
  # 全カテゴリー名とそれぞれの記事の数をハッシュで取得
  # {category.name : articles_num}
  def self.get_names_with_articles
    category_names = {}
    categories = Category.includes(:articles)

    categories.each do |category|
      if category.articles.size < 1
        category.destroy
        next
      end
      category_names.store(category.name, category.articles.size)
    end
    # 降順に並び替える
    category_names.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }.to_h
  end

end
