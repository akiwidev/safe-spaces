class Koban < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :address, :name, presence: true
end
