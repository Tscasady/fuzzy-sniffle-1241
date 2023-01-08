require 'rails_helper'

RSpec.describe 'Chef Ingredient Index Page', type: :feature do

  let!(:chef_1) { Chef.create!(name: "Tim") }
  let!(:chef_2) { Chef.create!(name: "Tom") }
  let!(:dish_1) { Dish.create!(name: "Fish", description: "tastes good", chef: chef_1) }
  let!(:dish_2) { Dish.create!(name: "Veggies", description: "very fresh", chef: chef_1) }
  let!(:dish_3) { Dish.create!(name: "Pasta", description: "kinda bland", chef: chef_2) }
  let!(:ingredient_1) { dish_1.ingredients.create!(name: 'salmon', calories: 300) }
  let!(:ingredient_2) { Ingredient.create!(name: 'butter', calories: 200) }
  let!(:ingredient_3) { dish_2.ingredients.create!(name: 'arugula', calories: 100) }
  let!(:ingredient_4) { Ingredient.create!(name: 'rice', calories: 250) }
  let!(:ingredient_5) { dish_3.ingredients.create!(name: 'cheese', calories: 350) }
  let!(:ingredient_6) { Ingredient.create!(name: 'salt', calories: 0) }
  let!(:dish_ing_1) { DishIngredient.create!(dish: dish_1, ingredient: ingredient_6) }
  let!(:dish_ing_2) { DishIngredient.create!(dish: dish_2, ingredient: ingredient_6) }
  let!(:dish_ing_3) { DishIngredient.create!(dish: dish_3, ingredient: ingredient_6) }
  let!(:dish_ing_4) { DishIngredient.create!(dish: dish_2, ingredient: ingredient_4) }
  let!(:dish_ing_5) { DishIngredient.create!(dish: dish_1, ingredient: ingredient_2) }
  let!(:dish_ing_6) { DishIngredient.create!(dish: dish_3, ingredient: ingredient_2) }


  describe 'displays ingredient information' do
    it 'displays all unique ingredients used by the chef' do
      visit chef_ingredients_path(chef_1) 

      expect(page).to have_content "salmon", count: 1
      expect(page).to have_content "rice", count: 1
      expect(page).to have_content "butter", count: 1
      expect(page).to have_content "salt", count: 1
      expect(page).to have_content "arugula", count: 1
      expect(page).to_not have_content "cheese"
    end
  end
end