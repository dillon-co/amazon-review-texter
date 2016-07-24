class ProductsController < ApplicationController

  def review_redirect
    p = Product.find(params[:id])
    p.update(review_count: p.review_count+1)
    redirect_to p.amazon_review_url
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end  
  
  def create
    product = Product.new(product_params)
    if product.save
      redirect_to root_path
    else
      render :new
    end    
  end

  def destroy
    product = Product.find(params[:id])
    product.delete
    redirect_to root_path
  end  

  def index
    @products = Product.all
  end  

  def show
    @product = Product.find(params[:id])
  end  

  private

  def product_params
    params.require(:product).permit(:name, :amazon_review_url, :amazon_id, :review_count)
  end  
end
