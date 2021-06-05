class ArticlesController < ApplicationController

    def index
        @articles = Article.includes(:category)
    end

    def new
        @article = Article.new
        @a = Article.all.destroy_all
        @c = Category.all.destroy_all
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

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @old_category = @article.category
        new_category_name = article_params[:category_name]
        # 異なる場合は新規作成、かつ他に使用している記事がない場合は削除
        if new_category_name != @old_category.name
            @article.category_id = Category.get_id(new_category_name)
            puts @article.category_id
            if @old_category.articles.count <= 1
                @old_category.destroy
            end
        end
        puts @article.inspect

        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新しました'
        else
            render 'show'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path, notice: '削除しました'
    end


    
    private
  
    def article_params
        params.require(:article).permit(:title, :content, :category_name, :category_id)
    end
end
