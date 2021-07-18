class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @categories = Category.get_names_with_articles
    @category_name = params[:category]
    category_id = @category_name ? Category.get_id(@category_name, false) : nil
    @sort_type = params[:sort_type]

    # お気に入り順の場合、sortメソッドを使用するため戻り値が配列になる
    if @sort_type == 'favorite'
      @articles = Kaminari.paginate_array(Article.sort(@sort_type, category_id)).page(params[:page]).per(9)
    else
      @articles = Article.sort(@sort_type, category_id).page(params[:page]).per(9)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.category_name.present?
      @article.category_id = Category.get_id(@article.category_name, true)
    else
      flash.now[:alert] = 'カテゴリーが入力されていません。'
      render 'new'  
      return    
    end
    
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
    if !new_category_name.present?
      flash.now[:alert] = 'カテゴリーが入力されていません。'
      render 'edit'
      return
    end
    
    # 異なる場合は新規作成、かつ他に使用している記事がない場合は削除
    if new_category_name != @old_category.name
      @article.category_id = Category.get_id(new_category_name, true)
      @old_category.destroy if @old_category.articles.count <= 1
    end

    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新しました'
    else
      render 'edit'
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
