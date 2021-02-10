class ItemsController < ApplicationController
  def new
    @customer = find_customer!
    @item = Item.new
  end

  def show
    @customer = find_customer!
    @item = find_item!
  end

  def edit
    @item = find_item!
  end

  def create
    @customer = find_customer!
    @item = Items::Create.run(item_params.merge(customer: @customer))

    redirect_to customer_path(@customer)
  end

  private

  def item_params
    params.require(:item).permit(:name, :length, :width, :height, :weight, :value)
  end

  def find_customer!
    customer = Customers::Find.run(id: params[:customer_id])

    raise ActiveRecord::RecordNotFound, customer.errors.full_messages.to_sentence unless customer.valid?

    customer.result
  end

  def find_item!
    item = Items::Find.run(params)

    raise ActiveRecord::RecordNotFound, item.errors.full_messages.to_sentence unless item.valid?

    item.result
  end
end
