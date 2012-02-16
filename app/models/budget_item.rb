class BudgetItem < ActiveRecord::Base

  attr_accessible :type, :units, :rate, :title, :balance_due_on

  validates_presence_of :rate, :title, :type
  validates_numericality_of :rate
  validates_presence_of :units, :if => "type == 'BudgetItem'"

  def total
    units * rate
  end
end
