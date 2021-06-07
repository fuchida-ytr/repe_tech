class Article < ApplicationRecord

    belongs_to :user
    belongs_to :category
    has_many   :favorites, dependent: :destroy 

    attr_accessor :category_name

end
