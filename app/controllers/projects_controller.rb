class ProjectsController < ApplicationController
  before_action :project, except: %i[index create]
  before_action :process_attributes, only: %i[create update]

  def index
    @projects ||= Project.kept

    render json: @projects.as_json(include: %i[developers technologies]), status: :ok
  end

  def show
    if @project.present?
      render json: @project.as_json(include: %i[developers technologies]), status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def create
    @project = Project.new(project_params)
    @project.start_date = Date.today

    @project.save
    respond_json(@project, include: %i[developers technologies])
  end

  def update
    if @project.present?
      @project.update(project_params)
      respond_json(@project, include: %i[developers technologies])
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def destroy
    if @project.present?
      if @project.discard
        render json: @project.to_json, status: :ok
      else
        render json: { error: 'Delete project failed'}, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def getTechnologyByProject
    if @project.present?
      render json: @project.technologies.to_json, status: :ok
    else
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  private

  def project
    @project ||= Project.kept.find_by(id: params[:id])
  end

  def process_attributes
    params[:project].merge!(developers_attributes: params[:project][:developers]) if params[:project][:developers].present?
    params[:project].merge!(technologies_attributes: params[:project][:technologies]) if params[:project][:technologies].present?
  end

  def project_params
    params.require(:project).permit(
      :name,
      :description,
      :end_date,
      developers_attributes: %i[first_name last_name],
      technologies_attributes: [:name]
    )
  end
end
