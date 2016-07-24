class ClientEmailsController < ApplicationController

  def index
  end  

  def new
    @product = Product.find(params[:product_id])
    @client_email = ClientEmail.new
    @client_email.product_id = @product.id
  end
  
  def create
    product = Product.find(params[:product_id])
    client_email = ClientEmail.new(email_params)
    if client_email.save
      client_email.update(product_id: product.id)
      redirect_to root_path
    else 
      render :new
    end   
  end

  def update
    client_email = Product.find(params[:id].client_email.update(email_params))
    if client_email.save
      redirect_to root_path
    else 
      render :new
    end   
  end  

  private

  def email_params
    params.require(:client_email).permit(:name, :email, :body, :document, :product_id)
  end  
end
