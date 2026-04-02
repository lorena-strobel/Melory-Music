class Category < ApplicationRecord
    has_many :items
    validates :name_category, presence: true, uniqueness: {case_sensitive: false}
    def self.ransackable_attributes(auth_object = nil)
  ["name_category", "id", "created_at"]
end
end
