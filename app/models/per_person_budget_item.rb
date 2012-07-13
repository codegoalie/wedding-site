class PerPersonBudgetItem < BudgetItem
  
  def units
    Attendee.count
  end
end
