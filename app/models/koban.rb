class Koban < ApplicationRecord
  validates :address, :name, presence: true
end
