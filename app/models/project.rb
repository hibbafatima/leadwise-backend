# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :invoices, dependent: :destroy
  belongs_to :user
end
