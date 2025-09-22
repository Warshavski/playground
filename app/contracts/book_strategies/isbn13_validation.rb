class BookStrategies::Isbn13Validation
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.present? && value !~ /\A\d+\z/
      @errors << I18n.t('errors.messages.contracts.book.isbn.isbn10_not_numeric')
    end

    @errors.empty?
  end
end