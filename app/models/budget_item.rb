class BudgetItem < ActiveRecord::Base

  attr_accessible :type, :units, :rate, :title, :balance_due_on

  validates_presence_of :rate, :title, :type
  validates_numericality_of :rate
  validates_presence_of :units, :if => "type == 'BudgetItem'"

  def total
    units * rate
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        BudgetItem.model_name
      end
    end
    super
  end
end
