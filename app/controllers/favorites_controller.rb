class FavoritesController < ApplicationController
  before_action :set_article, only: %i[create destroy]
  before_action :authenticate_user!

  def index
    # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    favorite_article_ids = Favorite.where(user_id: current_user.id).pluck(:article_id)
    @favorite_articles = Article.find(favorite_article_ids)
    @categories = Category.get_names_with_articles
  end

  # お気に入り登録
  def create
    @favorite = Favorite.create(user_id: current_user.id, article_id: @article.id)
  end

  # お気に入り削除
  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
    @favorite.destroy
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
