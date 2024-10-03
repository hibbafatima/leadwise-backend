# frozen_string_literal: true

# config/initializers/session_store.rb

if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_leadwise', domain: 'leadwise'
else
  Rails.application.config.session_store :cookie_store, key: '_leadwise'
end
