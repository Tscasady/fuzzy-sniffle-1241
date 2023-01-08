class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
  end

  def update
    dish = Dish.find(chef_params[:dish_id])
    dish.update!(chef_id: params[:id])
    redirect_to chef_path(params[:id])
  end

  private

  def chef_params
    params.require(:chef).permit(:dish_id)
  end
end