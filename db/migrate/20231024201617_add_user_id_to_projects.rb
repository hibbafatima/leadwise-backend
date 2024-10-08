# frozen_string_literal: true

class AddUserIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :user, null: false, foreign_key: true
  end
end
