class Payment < ActiveRecord::Base
  belongs_to :budget_item

  attr_accessible :budget_item_id, :paid_on, :amount, :check_number

  validates_presence_of :amount, :paid_on
  validates_numericality_of :amount
end
