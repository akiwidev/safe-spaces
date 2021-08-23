class Space < ApplicationRecord
  belongs_to :user
  has_many :incidents, dependent: :destroy
  # has_one_attached :photo

  validates :address, presence: true
end
