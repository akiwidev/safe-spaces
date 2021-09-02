class Incident < ApplicationRecord
  belongs_to :space
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
