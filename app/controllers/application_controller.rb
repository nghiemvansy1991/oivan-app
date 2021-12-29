class ApplicationController < ActionController::API
  private

  def respond_json(model, include_json = {})
    if model.errors.empty?
      render json: model.as_json(include_json), status: :ok
    else
      render json: model.errors, status: :unprocessable_entity
    end
  end
end
