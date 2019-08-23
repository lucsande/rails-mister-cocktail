class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :create, :edit, :update, :destroy]
  def new
    @dose = Dose.new(cocktail_id: params[:cocktail_id])
  end

  def create
    @dose = Dose.new(params_dose)
    @dose.cocktail = @cocktail
    if @dose.save
      flash[:notice] = "Sucessfully added #{@dose.ingredient.name}"
    else
      flash[:error] = "All field are required; ingredients can't repeat"
    end

    redirect_to cocktail_path(params[:cocktail_id])
  end

  def edit
    @doses = @cocktail.doses
  end

  def update
    @dose = Dose.find(params[:id])
    if @dose.update(params_dose)
      @message = "#{@cocktail.name}'s ingredients have been succesfully updated"
      redirect_to edit_cocktail_dose_path(@cocktail, @dose, message: @message)
      # redirect_to cocktail_path(@cocktail)
      # render 'edit'
    else
      # @doses = @cocktail.doses
      @message = "Couldn't update the ingredient, please check for error messages"
      render 'edit'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to edit_cocktail_dose_path(@cocktail, @dose, message: @message)

  end

  private

  def params_dose
    params.require(:dose).permit(:quantity, :unit, :ingredient_id)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
