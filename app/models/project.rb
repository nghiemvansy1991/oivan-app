class Project < ApplicationRecord
  has_many :developers, dependent: :destroy
  has_many :technologies, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :developers, allow_destroy: true
  accepts_nested_attributes_for :technologies, allow_destroy: true
end
