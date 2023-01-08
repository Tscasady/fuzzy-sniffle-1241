require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe '#total_calories' do
    
    let!(:chef_1) { Chef.create!(name: "Tim") }
    let!(:dish_1) { Dish.create!(name: "Fish", description: "tastes good", chef: chef_1) }
    let!(:dish_2) { Dish.create!(name: "Veggies", description: "very fresh", chef: chef_1) }
    let!(:ingredient_1) { dish_1.ingredients.create!(name: 'salmon', calories: 300) }
    let!(:ingredient_2) { dish_1.ingredients.create!(name: 'butter', calories: 200) }
    let!(:ingredient_3) { dish_2.ingredients.create!(name: 'arugula', calories: 100) }
    let!(:ingredient_4) { Ingredient.create!(name: 'salt', calories: 0) }
    let!(:dish_ing_1) { DishIngredient.create!(dish: dish_1, ingredient: ingredient_4) }
    let!(:dish_ing_2) { DishIngredient.create!(dish: dish_2, ingredient: ingredient_4) }

    it 'returns the total calories in a dish' do
      expect(dish_1.total_calories).to eq 500 
      expect(dish_2.total_calories).to eq 100 
    end
  end
end