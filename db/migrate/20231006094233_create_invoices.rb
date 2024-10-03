# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.references :project, null: false, foreign_key: true
      t.date :tenure_start_date
      t.date :tenure_end_date
      t.date :invoice_creation_date
      t.date :invoice_deadline
      t.text :payment_details

      t.timestamps
    end
  end
end
