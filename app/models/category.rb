class Category < ApplicationRecord
    has_many :items
    validates :name_category, presence: true, uniqueness: { case_sensitive: false }
    def self.ransackable_attributes(auth_object = nil)
      [ "name_category", "id", "created_at" ]
    end
    def self.ransackable_associations(auth_object = nil)
      [ "items" ]
    end
end
