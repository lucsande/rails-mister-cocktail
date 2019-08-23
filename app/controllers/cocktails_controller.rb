class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit]
  def index
    @cocktails = Cocktail.all
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      @dose = Dose.new
      redirect_to cocktail_path(@cocktail.id)
    else
      render 'new'
    end
  end

  def edit
    @doses = @cocktail.doses
    @new_dose = Dose.new
  end

  def update
  end

  def destroy
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
