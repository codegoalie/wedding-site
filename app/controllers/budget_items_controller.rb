class BudgetItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_budget_item_types, :except => [ :index, :delete ]

  def index
    @title = "Budget"
    @items = BudgetItem.order('lower(title)').all
  end

  def new
    @title = 'New Budget Item'
    @item = BudgetItem.new
  end

  def create
    @item = BudgetItem.new(params[:budget_item])
    @title = 'New Budget Item'

    if @item.save
      flash[:success] = "Budget Item Succesfully Saved"
      redirect_to budget_items_path
    else
      render 'new'
    end
  end

  def edit
    @item = BudgetItem.find params[:id]
    @title = "Editing #{@item.title}"
  end

  def update
    @item = BudgetItem.find params[:id]
    @title = "Editing #{@item.title}"

    if @item.update_attributes(params[:budget_item])
      flash[:success] = "#{@item.title} successfully updated."
      redirect_to budget_items_path
    else
      render 'edit'
    end
  end

  def destroy
    @item = BudgetItem.find params[:id]
    @item.destroy
    flash[:notice] = "#{@item.title} deleted."
    redirect_to budget_items_path
  end

  protected

    def load_budget_item_types
      @item_types = [ [ 'Standard', 'BudgetItem'], 
                      [ 'Per Person', 'PerPersonBudgetItem'],
                      [ 'Flat Rate', 'FlatRateBudgetItem' ]
                    ]
    end
end

