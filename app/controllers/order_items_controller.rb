class OrderItemsController < ApplicationController
  before_action :authenticate_customer!
end
