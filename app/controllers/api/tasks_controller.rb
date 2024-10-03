# frozen_string_literal: true

module Api
  class TasksController < ApplicationController
    before_action :set_task, only: %i[show update destroy]
    before_action :authenticate_user

    def index
      @tasks = current_user.tasks
      render json: @tasks
    end

    def create
      @task = current_user.tasks.build(task_params)
      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @task
    end

    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy
      head :no_content
    end

    private

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :task_details, :due_date, :severity, :assignee_name, :assignee_email,
                                   :status)
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
