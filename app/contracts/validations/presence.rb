class Validations::Presence
  attr_reader :errors

  def initialize
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.blank?
      @errors << I18n.t('errors.messages.contracts.presence')
    end
    @errors.empty?
  end
end