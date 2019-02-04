class RequestResult < ApplicationRecord
  validates :raw_data, presence: true, format: { with: /balances/ }
  validates :parsed_data, presence: true, on: :update
  scope :nonparced, -> { where parsed_data: {} }
end
