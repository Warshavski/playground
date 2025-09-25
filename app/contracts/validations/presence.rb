class Validations::Presence
  attr_reader :errors

  def initialize(opt)
    @opt = opt
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.present? == @opt
      return true
    end
    @errors << I18n.t('errors.messages.contracts.presence')
    false
  end
end
