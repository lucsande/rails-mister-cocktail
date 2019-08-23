class Dose < ApplicationRecord
  validates :quantity, :unit, :ingredient_id, presence: true
  validates_uniqueness_of :cocktail_id, scope: [:ingredient_id]

  belongs_to :cocktail
  belongs_to :ingredient
end
