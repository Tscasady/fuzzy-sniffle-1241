require 'rails_helper'

RSpec.describe 'The dish show page', type: :feature do
  describe 'when a user visits the dish show page' do

    let!(:chef_1) { Chef.create!(name: "Tim") }
    let!(:chef_2) { Chef.create!(name: "Tom") }
    let!(:dish_1) { Dish.create!(name: "Fish", description: "tastes good", chef: chef_1) }
    let!(:dish_2) { Dish.create!(name: "Veggies", description: "very fresh", chef: chef_1) }
    let!(:dish_3) { Dish.create!(name: "Pasta", description: "kinda bland", chef: chef_1) }

    it 'displays the dish name, the name of the chef the dish belongs to, and its description' do
      visit dish_path(dish_1)    

      expect(page).to have_content "Dish Name: #{dish_1.name}"
      expect(page).to have_content "Chef Name: #{chef_1.name}"
      expect(page).to have_content "Description: #{dish_1.description}"
    end
    
    it 'displays the dish ingredients' do

    end

    it 'displays the total calorie count for the dish' do

    end
  end
end