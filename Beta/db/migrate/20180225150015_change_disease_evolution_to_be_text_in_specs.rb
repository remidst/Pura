class ChangeDiseaseEvolutionToBeTextInSpecs < ActiveRecord::Migration[5.1]
  def change
  	change_column :specs, :disease_evolution, :text
  end
end
