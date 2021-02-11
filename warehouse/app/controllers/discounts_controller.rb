class DiscountsController < ApplicationController
  def new
    @customer = find_customer!
    @discount = Discount.new
  end

  def edit
    @customer = find_customer!
    @discount = find_discount!
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
    @customer = find_customer!
    @discount = find_discount!

    result = Discounts::Update.run(discount_params.merge(discount: @discount))

    if result.valid?
      redirect_to customer_path(@customer)
    else
      @discount = result
      render :edit
    end
  end

  def destroy
    Discounts::Destroy.run!(discount: find_discount!)

    redirect_to customer_path(find_customer!)
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
    discount = Discounts::Find.run(params)

    raise ActiveRecord::RecordNotFound, discount.errors.full_messages.to_sentence unless discount.valid?

    discount.result
  end
end
