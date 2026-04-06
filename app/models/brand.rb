class Brand < ApplicationRecord
    has_many :items
    validates :name_brand, presence: true, uniqueness: { case_sensitive: false, message: "Marca já cadastrada no sistema" }
    def self.ransackable_attributes(auth_object = nil)
      [ "name_brand", "id", "created_at" ]
    end
    def self.ransackable_associations(auth_object = nil)
      [ "items" ]
    end
end
