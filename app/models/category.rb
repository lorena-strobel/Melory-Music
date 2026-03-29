class Category < ApplicationRecord
    has_many :items
    validates :name_category, presence: true, uniqueness: {case_sensitive: false}
end
