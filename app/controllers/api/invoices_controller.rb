# frozen_string_literal: true

module Api
  class InvoicesController < ApplicationController
    before_action :set_project
    before_action :set_invoice, only: %i[show preview download]
    before_action :authenticate_user

    def index
      @invoices = @project.invoices.includes(:project)
      render json: @invoices, include: [:project]
    end

    def create
      @invoice = @project.invoices.new(invoice_params)
      if @invoice.save
        render json: @invoice, status: :created
      else
        render json: @invoice.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @invoice
    end

    def download
      @invoice = Invoice.find(params[:id])

      pdf = InvoicePdf.new(@invoice)

      send_data pdf.render, type: 'application/pdf', disposition: 'inline'
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_invoice
      @invoice = @project.invoices.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:start_date, :end_date, :deadline, :payment_details, :tenure_start_date,
                                      :tenure_end_date, :invoice_creation_date, :invoice_deadline, :template_type)
    end

    def authenticate_user
      return if current_user

      render json: 'not logged in', status: :unprocessable_entity
    end
  end
end
