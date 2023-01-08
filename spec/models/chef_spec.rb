require 'rails_helper'

RSpec.describe Chef, type: :model do

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

  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it { should have_many :dishes }
    it { should have_many :ingredients }
  end

  describe '#uniq_ingredients' do
    it 'returns a unique list of ingredients used by the chef in all dishes' do
      expect(chef_1.uniq_ingredients).to eq [ingredient_1, ingredient_2, ingredient_3, ingredient_4, ingredient_6]
      expect(chef_2.uniq_ingredients).to eq [ingredient_2, ingredient_5, ingredient_6]
    end
  end

  describe '#popular_ingredients' do
    it 'returns the top three most used ingredients across all dishes' do
      dish_3.update(chef: chef_1)

      expect(chef_1.popular_ingredients).to eq [ingredient_6, ingredient_2, ingredient_1] 
    end
  end
end