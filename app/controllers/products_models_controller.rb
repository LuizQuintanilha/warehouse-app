class ProductsModelsController < ApplicationController
  def index
    @products_models = ProductModel.all
  end
end