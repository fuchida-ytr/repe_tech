class ArticlesController < ApplicationController

    def index
        @articles = Article.includes(:category)
    end

    def new
        @article = Article.new
    end

    def create 
        @article = current_user.articles.build(article_params)
        @article.category_id = Category.get_id(@article.category_name)
        @article.save!
        redirect_to article_path(@article), notice: '作成しました'
    end

    def show
        @article = Article.find(params[:id])
    end

    private
  
    def article_params
        params.require(:article).permit(:title, :content, :category_name, :category_id)
    end
end
