class HomeController < ApplicationController

  def index
  end

  # キーワードを含むセクション、記事を検索
  def search
    @sections = Section.search(params[:keyword]).limit(5)
    @articles = Article.search(params[:keyword]).limit(5)
    @keyword = params[:keyword]
		# @diaries = Diary.search(params[:search]).order(id: :desc).page(params[:page]).per(9)
	end
end
