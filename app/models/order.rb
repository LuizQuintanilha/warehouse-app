class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :user
  belongs_to :supplier
  has_many :order_items
  has_many :product_models, through: :order_items

  enum status: { pending: 0, delivered: 5, canceled: 9 }

  validates :code, :estimated_delivery_date, presence: true
  validate :estimated_delivery_date_cannot_be_in_the_pass

  before_validation :generate_code, on: :create

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_cannot_be_in_the_pass
    return unless estimated_delivery_date.present? && estimated_delivery_date <= Date.today

    errors.add(:estimated_delivery_date, 'A data não pode ser inferior a data atual')
  end
end
