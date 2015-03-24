class CompaniesController < ApplicationController
  authorize_resource

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find params[:id]
  end

  def new
    @company = Company.new
  end
end
