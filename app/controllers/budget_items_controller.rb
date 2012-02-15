class BudgetItemsController < ApplicationController

  def index
    @title = "Budget"
    @items = BudgetItem.all
  end

  def new
    @title = 'New Budget Item'
    @item_types = [ [ 'Standard', 'BudgetItem'], 
                    [ 'Per Person', 'PerPersonBudgetItem'],
                    [ 'Flat Rate', 'FlatRateBudgetItem' ]
                  ]
  end

  def create
    @item = BudgetItem.new(params)

    if @item.save
      flash[:success] = "Budget Item Succesfully Saved"
      redirect_to budget_items_path
    else
      render 'new'
    end
  end
end
