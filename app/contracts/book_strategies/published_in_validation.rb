class BookStrategies::PublishedInValidation
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.blank?
      @errors << I18n.t('errors.messages.contracts.book.published_in.blank')
    end

    @errors.empty?
  end
end