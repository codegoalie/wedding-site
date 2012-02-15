class BudgetItem < ActiveRecord::Base

  attr_accessible :type, :units, :rate, :title, :balance_due_on

  def total
    units * rate
  end
end
