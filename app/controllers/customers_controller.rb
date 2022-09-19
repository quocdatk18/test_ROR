# frozen_string_literal: true

# lass CustomersController
class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find_by(id: params[:id])
  end
end
