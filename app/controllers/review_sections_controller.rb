class ReviewSectionsController < ApplicationController
    before_action :set_section, only: [:create, :destroy]
    before_action :authenticate_user!

    def index
    end

    def create
        @section = Section.find(params[:section_id])
        @review_section = ReviewSection.create(user_id: current_user.id, section_id: @section.id, next_review_date: Date.tomorrow)
    end

    def destroy
        @section = Section.find(params[:section_id])
        @review_section = ReviewSection.find_by(user_id: current_user.id, section_id: @section.id)
        @review_section.destroy
    end

    private

    def set_section
        @section = Section.find(params[:section_id])
    end
end
