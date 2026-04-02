class Brand < ApplicationRecord
    has_many :items
    validates :name_brand, presence: true, uniqueness: { case_sensitive: false }
    def self.ransackable_attributes(auth_object = nil)
  ["name_brand", "id", "created_at"]
end
end
