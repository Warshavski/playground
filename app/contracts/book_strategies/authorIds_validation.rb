class BookStrategies::AuthorIdsValidation
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.blank?
      @errors << I18n.t('errors.messages.contracts.book.author_ids.blank')
    end

    @errors.empty?
  end
end