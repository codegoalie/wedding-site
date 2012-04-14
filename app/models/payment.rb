class Payment < ActiveRecord::Base
  belongs_to :budget_item

  validates_presence_of :amount, :paid_on
  validates_numericality_of :amount
end
