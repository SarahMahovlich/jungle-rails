class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(id: params[:id])
    if !@category
      redirect_to root_path
    else
      @products = @category.products.order(created_at: :desc)
    end 
    
  end

end
