# frozen_string_literal: true

class AddEncryptedColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :encrypted_password_iv, :string
  end
end
