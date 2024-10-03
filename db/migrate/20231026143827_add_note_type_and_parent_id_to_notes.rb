# frozen_string_literal: true

class AddNoteTypeAndParentIdToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :note_type, :integer
    add_column :notes, :parent_id, :bigint
    add_index :notes, :parent_id
  end
end
