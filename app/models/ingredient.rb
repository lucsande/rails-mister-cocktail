class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  before_destroy :ingredient_has_no_cocktail?

  has_many :doses
  has_many :cocktails, through: :doses

  private

  def ingredient_has_no_cocktail?
    self.cocktails.empty?
  end
end
