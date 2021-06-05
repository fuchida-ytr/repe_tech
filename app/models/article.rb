class Article < ApplicationRecord

    belongs_to :user
    belongs_to :category

    attr_accessor :category_name

end
