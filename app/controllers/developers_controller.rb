class DevelopersController < ApplicationController
  before_action :project
  before_action :developer, except: %i[index create]

  def index
    if @project.present?
      @developers = @project.developers
      render json: @developers.to_json, status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def show
    if @developer.present?
      render json: @developer.to_json, status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def create
    if @project.present?
      @developer = @project.developers.new(developer_params)

      @developer.save
      respond_json(@developer)
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def update
    if @developer.present?
      @developer.update(developer_params)
      respond_json(@developer)
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def destroy
    if @developer.present?
      if @developer.discard
        render json: @developer.to_json, status: :ok
      else
        render json: { error: 'Delete developer failed'}, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  private

  def project
    @project ||= Project.kept.find_by(id: params[:project_id])
  end

  def developer
    @developer ||= @project.developers.find_by(id: params[:id]) if @project.present?
  end

  def developer_params
    params.require(:developer).permit(
      :first_name,
      :last_name,
    )
  end
end
