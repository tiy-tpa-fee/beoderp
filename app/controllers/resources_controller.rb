# Magic!
class ResourcesController < ApplicationController
  before_action :define_scope
  before_action :set_resource, only: [:show, :update, :destroy]

  wrap_parameters false

  # GET /resources
  def index
    @resources = @scope.order(created_at: :asc)

    render json: @resources
  end

  # GET /resources/1
  def show
    render json: @resource
  end

  # POST /resources
  def create
    !params[:_json] ? create_resource : create_resources
  end

  # PATCH/PUT /resources/1
  def update
    if @resource.update(data: request.request_parameters)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy
  end

  private

  def define_scope
    @scope = current_user.resources.by_name(params[:resource_name])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = @scope.find(params[:id])
  end

  # Create a single Resource
  def create_resource
    @resource = @scope.new(data: request.request_parameters)
    if @resource.save
      render json: @resource, status: :created, location: resource_url(@resource.name, @resource.id)
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # Bulk create Resources
  def create_resources
    @resources = @scope.create(params[:_json].map { |res| { data: res } })
    render json: @resources, status: :created, location: resources_url
  rescue
    render nothing: true, status: :unprocessable_entity
  end
end
