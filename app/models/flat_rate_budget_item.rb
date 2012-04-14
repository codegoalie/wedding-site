class FlatRateBudgetItem < BudgetItem
  before_save :set_units_to_one

  attr_reader :units

  def units
    1
  end

  protected

    def set_units_to_one
      self.units = 1
    end
end
