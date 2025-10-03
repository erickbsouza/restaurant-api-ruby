class Menu < ApplicationRecord
    belongs_to :restaurant
    has_and_belongs_to_many :menu_items
    validates :name, presence: true, length: { in: 3..50 }
end
