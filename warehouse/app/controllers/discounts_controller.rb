class DiscountsController < ApplicationController
  def new
    @customer = find_customer!
    @discount = Discount.new
  end

  def edit
  end

  def create
    @customer = find_customer!
    result = Discounts::Create.run(discount_params.merge(customer: @customer))

    if result.valid?
      redirect_to customer_path(@customer)
    else
      @discount = result
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage_off, :item_coverage_from, :item_coverage_to)
  end

  def find_customer!
    customer = Customers::Find.run(id: params[:customer_id])

    raise ActiveRecord::RecordNotFound, customer.errors.full_messages.to_sentence unless customer.valid?

    customer.result
  end

  def find_discount!
    discount = Discount::Find.run(params)

    raise ActiveRecord::RecordNotFound, discount.errors.full_messages.to_sentence unless discount.valid?

    discount.result
  end
end
