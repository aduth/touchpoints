class ServiceProvider < ApplicationRecord
  belongs_to :organization
  has_many :services
  has_many :collections, through: :services

  validates :slug, presence: true
end
