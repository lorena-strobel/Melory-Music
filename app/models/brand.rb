class Brand < ApplicationRecord
    has_many :items
    validates :name_brand, presence: true, uniqueness: { case_sensitive: false }
end
