class BookStrategies::TitleValidation
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.blank?
      @errors << I18n.t('errors.messages.contracts.book.title.empty_title')
    elsif value.length < 2
      @errors << I18n.t('errors.messages.contracts.book.title.short_title')
    elsif value.length > 80
      @errors << I18n.t('errors.messages.contracts.book.title.long_title')
    end

    @errors.empty?
  end
end