class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :user
  belongs_to :supplier

  validates :code, presence: true

  before_validation :generate_code
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
