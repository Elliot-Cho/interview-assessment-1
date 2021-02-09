# Controller for customer model
class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = ::Customers::Create.run!(customer_params)

    redirect_to @customer
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :charge_type, :charge_value, :flat_fee)
  end
end
