# frozen_string_literal: true

module Api
  class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show update destroy]
    before_action :authenticate_user

    def index
      @projects = current_user.projects
      render json: @projects
    end

    def create
      @project = current_user.projects.build(project_params)
      if @project.save
        render json: @project, status: :created
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @project
    end

    def update
      if @project.update(project_params)
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @project.destroy
      head :no_content
    end

    private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def authenticate_user
      return if current_user

      respond_to do |format|
        format.html do
          render json: { error: 'Authentication required' }, status: :unauthorized
        end

        format.json do
          render json: { error: 'Authentication required' }, status: :unauthorized
        end
      end
    end
  end
end
