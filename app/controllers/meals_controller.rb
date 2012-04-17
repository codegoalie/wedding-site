class MealsController < ApplicationController
  def index
    @title = 'Meals'
    @meals = Meal.all
  end

  def new
    @title = 'New Meal'
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(params[:meal])

    if @meal.save
      redirect_to meals_path, :success => "Meal successfully added."
    else
      render :new
    end
  end

  def show
    @meal = Meal.find params[:id]
    @title = @meal.title
  end


  def edit
    @meal = Meal.find params[:id]
    @title = "Editing #{@meal.title}"
  end

  def update
    @meal = Meal.find params[:id]

    if @meal.update_attributes(params[:meal])
      redirect_to meals_path, :success => "#{@meal.title} successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @meal = Meal.find params[:id]

    if @meal.destroy
      redirect_to meals_path, :success => "Meal successfully deleted."
    else
      render :show
    end
  end
end
