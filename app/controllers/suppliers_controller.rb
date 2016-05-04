class SuppliersController < ApplicationController
  before_action :authenticate_admin!
end
