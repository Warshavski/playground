# frozen_string_literal: true

module Books
  class StatesController < ApplicationController
    before_action :doorkeeper_authorize!

    def update
      book = ::Book.find(params[:book_id])
      event = params.require(:event)

      if event == 'submit_for_review'
        authorize! book, to: :submit_for_review?
        book.submit_for_review!
      elsif event == 'publish'
        authorize! book, to: :publish?
        book.publish!
      elsif event == 'reject'
        authorize! book, to: :reject?
        book.reject!
      elsif event == 'revise'
        authorize! book, to: :revise?
        book.revise!
      else
        return head :unprocessable_entity
      end

      render json: book, serializer: BookSerializer
    end
  end
end
