class PerPersonBudgetItem < BudgetItem
  
  def units
    Guest.sum(:count)
  end
end
