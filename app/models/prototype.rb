class Prototype < ApplicationRecord

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  belongs_to :user
  #has_many :user
  #belongs_to :commnet
  has_one_attached :image
  has_many :comment                #prototype_comment, dependent: :destroy

end
