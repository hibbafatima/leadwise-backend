# frozen_string_literal: true

# app/models/user.rb

class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  attr_encrypted :email, key: '8b61ae28ee49fa9bb905a8b2867f871e'
  attr_encrypted :password, key: '8b61ae28ee49fa9bb905a8b2867f871e'
  before_save { self.email = email.downcase }

  has_many :projects, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_one :resume, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
