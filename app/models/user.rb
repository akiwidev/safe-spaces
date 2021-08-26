class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spaces, dependent: :destroy
  has_many :incidents
  has_many :messages_as_sender, class_name: "message", foreign_key: :sender_id
  has_many :messages_as_receiver, class_name: "message", foreign_key: :receiver_id
  has_one_attached :photo

  validates :first_name, :last_name, :phone_num, :photo, presence: true
end
