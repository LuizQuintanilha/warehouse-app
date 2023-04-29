class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      flash[:notice]  = 'Modelo de produto cadastrado com sucesso.'
      redirect_to @product_model
    else
      flash.now[:notice] = 'Não foi possível cadastrar o produto.'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end


  def product_model_params
    params.require(:product_model).permit(:name, :weight, :height, :width, :depth, :sku, :supplier_id)
  end
end