# frozen_string_literal: true

# app/controllers/api/users_controller.rb

module Api
  class UsersController < ApplicationController
    def index
      @users = User.all
      if @users
        render json: {
          users: @users
        }
      else
        render json: {
          status: 500,
          errors: ['no users found']
        }
      end
    end

    def dashboard
      user = current_user
      projects = user.projects.includes(:invoices).order(created_at: :desc).limit(5)
      notes = user.notes.order(tag: :desc).limit(5)
      upcoming_invoices = projects.map do |project|
        project.invoices.where('invoice_deadline > ?', Date.today)
               .order(invoice_deadline: :desc)
               .limit(5)
               .map { |invoice| { invoice: invoice, project_name: invoice.project.name } }
      end.flatten
      tasks = user.tasks.order(severity: :desc)

      dashboard_data = {
        user: user,
        projects: projects,
        notes: notes,
        upcoming_invoices: upcoming_invoices,
        tasks: tasks
      }
      render json: dashboard_data
    end

    def show
      @user = User.find(params[:id])
      if @user
        render json: {
          user: @user
        }
      else
        render json: {
          status: 500,
          errors: ['user not found']
        }
      end
    end

    def user_invoices
      user = User.find_by(email: 'user@example.com')

      @invoices = user.projects.map(&:invoices).flatten
      render json: @invoices
    end

    def create
      @user = User.new(user_params)
      if @user.save
        login!
        render json: {
          status: :created,
          user: @user
        }
      else
        render json: {
          status: 500,
          errors: @user.errors.full_messages
        }
      end
    end

    private

    def user_params
      params.permit(:first_name, :last_name, :email, :password)
    end
  end
end
