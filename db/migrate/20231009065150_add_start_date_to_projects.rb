# frozen_string_literal: true

class AddStartDateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :start_date, :date
  end
end
