require 'rails_helper'

RSpec.describe 'The chef show page', type: :feature do


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

  describe 'displays chef information' do
    it 'displays the name and dishes of the chef' do
      visit chef_path(chef_1)
      
      expect(page).to have_content "Chef: Tim"      
      expect(page).to_not have_content "Chef: Tom"      
      expect(page).to have_content "Fish"
      expect(page).to have_content "Veggies"
      expect(page).to_not have_content "Pasta"
    end
  end

  describe 'New Dish' do
    it 'has a form to add a new dish for the chef' do
      visit chef_path(chef_1)

      expect(page).to have_field "chef[dish_id]"
      expect(page).to have_button "Add Dish"
    end

    it 'can display a new dish for the chef when a dish id is submitted' do
      visit chef_path(chef_1)
      
      expect(page).to_not have_content "Pasta"

      fill_in "chef[dish_id]", with: dish_3.id
      click_button "Add Dish"

      expect(current_path).to eq chef_path(chef_1)
      expect(page).to have_content "Pasta"
    end
  end

  describe "All Ingredients" do
    it 'has a link to that chefs ingredient index page' do
      visit chef_path(chef_1)

      expect(page).to have_link "All Ingredients"
      
      click_link "All Ingredients"

      expect(current_path).to eq chef_ingredients_path(chef_1)
    end
  end
end