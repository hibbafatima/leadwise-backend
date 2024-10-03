# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :project
  has_many :notes, dependent: :destroy

  validates :tenure_start_date, presence: true
  validates :tenure_end_date, presence: true
  validate :validate_no_overlap

  private

  def validate_no_overlap
    return if project.nil? || tenure_start_date.blank? || tenure_end_date.blank?

    existing_invoices = project.invoices.where.not(id: id)
    if existing_invoices.exists?([
                                   '(tenure_start_date <= ? AND tenure_end_date >= ?) OR (tenure_start_date <= ? AND tenure_end_date >= ?)', tenure_start_date, tenure_start_date, tenure_end_date, tenure_end_date
                                 ])
      errors.add(:base, 'Invoice date range overlaps with an existing invoice for this project.')
    end
  end
end
