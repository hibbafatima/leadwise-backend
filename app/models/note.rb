# frozen_string_literal: true

class Note < ApplicationRecord
  enum tag: { low: 0, medium: 1, high: 2 }
  validates_presence_of :title, :description, :tag
  enum note_type: { project: 0, invoice: 1 }
  belongs_to :user
end
