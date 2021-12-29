class TechnologiesController < ApplicationController
  before_action :technology, except: %i[index create]

  def index
    @technologies = Technology.kept
    render json: @technologies.to_json, status: :ok
  end

  def show
    if @technology.present?
      render json: @technology.to_json, status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def create
    @technology = Technology.new(technology_params)

    @technology.save
    respond_json(@technology)
  end

  def update
    if @technology.present?
      @technology.update(technology_params)
      respond_json(@technology)
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def destroy
    if @technology.present?
      if @technology.project.blank?
        if @technology.discard
          render json: @technology.to_json, status: :ok
        else
          render json: { error: 'Delete technology failed'}, status: :unprocessable_entity
        end
      else
        render json: { error: "Can't delete technology because it's belong to project"}, status: :internal_server_error
      end
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  private

  def technology
    @technology ||= Technology.kept.find_by(id: params[:id])
  end

  def technology_params
    params.require(:technology).permit(:name)
  end
end
