class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @sort_type = params[:sort_type]
    # @articles = Article.includes(:category).order(id: :desc).page(params[:page]).per(9)
    if @sort_type == 'favorite'
      @articles = Kaminari.paginate_array(Article.sort(@sort_type)).page(params[:page]).per(9)
    else
      @articles = Article.sort(@sort_type).page(params[:page]).per(9)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.category_id = Category.get_id(@article.category_name)
    if @article.save
      redirect_to article_path(@article), notice: '作成しました。'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @old_category = @article.category
    new_category_name = article_params[:category_name]
    # 異なる場合は新規作成、かつ他に使用している記事がない場合は削除
    if new_category_name != @old_category.name
      @article.category_id = Category.get_id(new_category_name)
      @old_category.destroy if @old_category.articles.count <= 1
    end

    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新しました'
    else
      render 'show'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: '削除しました'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :category_name, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def ensure_correct_user
    if current_user.id != @article.user_id
      flash[:alert] = 'アクセス権限がありません。'
      redirect_back(fallback_location: homes_path)
    end
  end
end
