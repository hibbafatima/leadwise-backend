# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    post '/login',    to: 'sessions#create'
    post '/logout',   to: 'sessions#destroy'
    get '/logged_in', to: 'sessions#is_logged_in?'
    resources :users, only: %i[create show index] do
      get 'dashboard', on: :collection
      get 'invoices', on: :member
      resources :notes
      resources :tasks
      resources :projects, except: %i[new edit], shallow: true do
        resources :invoices, only: %i[index create] do
          get 'download', on: :member
        end
      end
      resources :resumes do
        collection do
          post 'generate_resume'
          post 'download_word_template'
        end
      end
    end
  end
end
