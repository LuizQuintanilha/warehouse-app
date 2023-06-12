class SuppliersController < ApplicationController
  # before_action :set_supplier, only: [:show, :new, :create]
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:notice] = 'Fornecedor cadastrado com sucesso.'
      redirect_to supplier_path(@supplier.id)
    else
      flash.now[:notice] = 'Não foi possível cadastrar fornecedor.'
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      flash[:notice] = 'Fornecedor atualizado com sucesso.'
      redirect_to supplier_path(@supplier.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar dados do forcenedor.'
      render 'edit'
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :zip, :city,
                                     :state, :email)
  end
end
