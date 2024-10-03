# frozen_string_literal: true

# app/pdfs/invoice_pdf.rb
class InvoicePdf < Prawn::Document
  def initialize(invoice)
    super()
    @invoice = invoice
    generate_pdf
  end

  def generate_pdf
    text "Invoice details for project: #{@invoice.project.name}"
    text "Tenure Start Date: #{@invoice.tenure_start_date}"
    text "Tenure End Date: #{@invoice.tenure_end_date}"
    text "Due Date: #{@invoice.invoice_deadline}"
    text "Creation Date: #{@invoice.invoice_creation_date}"
    text "Payment details: #{@invoice.payment_details}"
  end
end
