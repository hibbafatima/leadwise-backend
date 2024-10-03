# frozen_string_literal: true

module Api
  class NotesController < ApplicationController
    before_action :set_note, only: %i[show update destroy]
    before_action :authenticate_user

    def index
      @notes = current_user.notes
      render json: @notes
    end

    def create
      @note = current_user.notes.new(note_params)

      if @note.save
        render json: @note, status: :created
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @note
    end

    def update
      if @note.update(note_params)
        render json: @note
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @note.destroy
      head :no_content
    end

    private

    def set_note
      @note = current_user.notes.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :description, :tag, :note_type, :parent_id)
    end

    def authenticate_user
      return if current_user

      render json: { error: 'Authentication required' }, status: :unauthorized
    end

    def authenticate_user
      return if current_user

      render json: 'not logged in', status: :unprocessable_entity
    end
  end
end
