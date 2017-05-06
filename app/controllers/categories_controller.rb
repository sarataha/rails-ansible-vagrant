class CategoriesController < ApplicationController
  # shows all categories
  def index
    @categories = Category.all
    render "/app/views/layouts/_category.html.erb"
  end

  def new
    @category = Category.new
  end

  # only admin is allowed to create a new category
  def create
    if admin?
      @category = Category.create(category_params)
      if @category
        flash[:success] = "New category Created"
        redirect_to dashboard_path
      else
        flash[:failure] = "Error in creating category"
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
    render template: "categories/new"
  end

  def show
    @category = Category.find(params[:id])
    render template: 'products/index.html.erb'
  end

  def category_params
    params.require(:category).permit(:title, :description)
  end
end
