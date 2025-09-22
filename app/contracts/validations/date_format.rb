class Validations::DateFormat
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.is_a?(Date) || value.is_a?(Time)
      @errors << I18n.t('errors.messages.contracts.book.isbn.isbn10_not_numeric')
    end

    @errors.empty?
  end
end