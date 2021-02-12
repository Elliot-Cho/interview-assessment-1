# Controller for customer model
class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:quote_from_input]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def show
    @customer = find_customer!
    @pricing = Customers::QuotePricing.run(customer: @customer).result
  end

  def edit
    @customer = find_customer!
  end

  def create
    result = Customers::Create.run(customer_params)

    if result.valid?
      redirect_to result
    else
      @customer = result
      render :new
    end
  end

  def update
    result = Customers::Update.run(customer_params.merge(customer: find_customer!))

    if result.valid?
      redirect_to result
    else
      @customer = result
      render :edit
    end
  end

  def destroy
    # Redundant, but just incase destroy needs to do more than delete the customer later
    Customers::Destroy.run!(customer: find_customer!)

    redirect_to root_path
  end

  # curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" --data-binary "@{path to file here}" "http://localhost:3000/customers/{customer id here}/quote_from_input"
  def quote_from_input
    customer = find_customer!

    input = request.body.read

    quote = Customers::QuotePricingFromInput.run(customer: customer, input: input)

    render json: quote.result
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :charge_type, :charge_value, :flat_fee)
  end

  def find_customer!
    customer = Customers::Find.run(params)

    raise ActiveRecord::RecordNotFound, customer.errors.full_messages.to_sentence unless customer.valid?

    customer.result
  end
end
