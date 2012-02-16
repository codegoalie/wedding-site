class BudgetItem < ActiveRecord::Base

  attr_accessible :type, :units, :rate, :title, :balance_due_on

  validates_presence_of :rate, :title, :type

  def total
    units * rate
  end
end
