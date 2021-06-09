class Category < ApplicationRecord
    has_many :articles

    def self.get_id(name)
        category = Category.find_by(name: name)
        if category.nil?
            category = Category.new(name: name)
            category.save
        end
        category.id
    end
end
