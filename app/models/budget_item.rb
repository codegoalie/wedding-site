class BudgetItem < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :payments, :dependent => :destroy

  attr_accessible :type, :units, :rate, :title, :balance_due_on

  default_scope order('lower(title)')

  validates_presence_of :rate, :title, :type
  validates_numericality_of :rate
  validates_presence_of :units, :if => "type == 'BudgetItem'"

  def title_with_total
    "#{title} (#{number_to_currency total})"
  end

  def total
    units * rate
  end

  def balance
    total - paid
  end
  
  def paid
    payments.collect{ |p| p.amount }.sum
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
