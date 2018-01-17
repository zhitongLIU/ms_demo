class JobsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # quick controller......

  def index
    render json: Job.all
  end

  def show
    render json: Job.find(params[:id])
  end

  def create
    render json: Job.create(name: params[:name], status: 'created')
  end

  def destroy
    Job.delete params[:id]
    head :no_content
  end
end
