class Validations::Numeric
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.present? && value !~ /\A\d+\z/
      @errors << I18n.t('errors.messages.contracts.date_format')
    end

    @errors.empty?
  end
end