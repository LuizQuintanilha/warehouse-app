class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: %i[show edit update delivered canceled]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save!
      flash[:notice] = 'Pedido registrado com sucesso.'
      redirect_to @order
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível salvar o pedido.'
      render 'new'
    end
  end

  def show; end

  def search
    @code = params['query']
    @orders = Order.where('code LIKE ?', "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order = Order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create!(
          order: @order,
          product_model: item.product_model,
          warehouse: @order.warehouse
        )
      end
    end
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])
    return unless @order.user != current_user

    redirect_to root_path, notice: 'Você não tem acesso ao este pedido.'
  end
end
