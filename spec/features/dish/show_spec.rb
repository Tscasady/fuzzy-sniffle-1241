require 'rails_helper'

RSpec.describe 'The dish show page', type: :feature do
  describe 'when a user visits the dish show page' do

    let!(:chef_1) { Chef.create!(name: "Tim") }
    let!(:chef_2) { Chef.create!(name: "Tom") }
    let!(:dish_1) { Dish.create!(name: "Fish", description: "tastes good", chef: chef_1) }
    let!(:dish_2) { Dish.create!(name: "Veggies", description: "very fresh", chef: chef_1) }
    let!(:dish_3) { Dish.create!(name: "Pasta", description: "kinda bland", chef: chef_1) }
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

    it 'displays the dish name, the name of the chef the dish belongs to, and its description' do
      visit dish_path(dish_1)    

      expect(page).to have_content "Dish Name: #{dish_1.name}"
      expect(page).to have_content "Chef Name: #{chef_1.name}"
      expect(page).to have_content "Description: #{dish_1.description}"
    end
    
    it 'displays the dish ingredients' do
      visit dish_path(dish_1)    

      expect(page).to have_content "#{ingredient_1.name}"
      expect(page).to have_content "#{ingredient_2.name}"
      expect(page).to have_content "#{ingredient_6.name}"
    end

    it 'displays the total calorie count for the dish' do

    end
  end
end