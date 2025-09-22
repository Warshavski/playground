class Validations::Length
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.length < 2 || value.length > 80
      @errors << I18n.t('errors.messages.contracts.length')
    end

    @errors.empty?
  end
end