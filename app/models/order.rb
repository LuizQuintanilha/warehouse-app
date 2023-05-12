class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :user
  belongs_to :supplier

  validates :code, :estimated_delivery_date, presence: true
  validate :estimated_delivery_date_cannot_be_in_the_pass

  before_validation :generate_code
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_cannot_be_in_the_pass
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, "A data não pode ser inferior a data atual")
    end
  end


end
