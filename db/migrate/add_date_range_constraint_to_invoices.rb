# frozen_string_literal: true
# Migration to add a date range constraint to the invoices table.

class AddDateRangeConstraintToInvoices < ActiveRecord::Migration[6.0]
  def change
    safety_assured do
      execute <<-SQL
        ALTER TABLE invoices
        ADD CONSTRAINT no_overlapping_invoices
        EXCLUDE USING GIST (
          project_id WITH =,
          daterange(tenure_start_date, tenure_end_date) WITH &&
        );
      SQL
    end
  end
end
vdsxx
