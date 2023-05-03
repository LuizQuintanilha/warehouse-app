class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :user
  belongs_to :supplier
end
