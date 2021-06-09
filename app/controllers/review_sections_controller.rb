class ReviewSectionsController < ApplicationController
    before_action :set_section, only: [:create, :destroy]
    before_action :authenticate_user!

    def index
    end

    # def index
    #     # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    #     favorites = Favorite.where(user_id: current_user.id).pluck(:section_id) 
    #     @favorite_sections = section.find(favorites)     
    # end

    # お気に入り登録
    # def create
    #     @favorite = Favorite.create(user_id: current_user.id, section_id: @section.id)
    # end
    # # お気に入り削除
    # def destroy
    #     @favorite = Favorite.find_by(user_id: current_user.id, section_id: @section.id)
    #     @favorite.destroy
    # end

    private

    def set_section
        @section = Section.find(params[:section_id])
    end
end
