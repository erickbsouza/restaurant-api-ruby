class Restaurant < ApplicationRecord
    has_many :menus, dependent: :destroy
    validates :name, presence: true, length: { in: 3..100 }
end
