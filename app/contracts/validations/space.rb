class Validations::Space
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.is_a?(String) && (value != value.strip)
      @errors << I18n.t('errors.messages.contracts.space')
    end

    @errors.empty?
  end
end