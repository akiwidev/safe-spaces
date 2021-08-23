class Incident < ApplicationRecord
  belongs_to :space
  belongs_to :user
  has_many :messages
end
