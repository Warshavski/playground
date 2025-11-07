class Validations::DateFormat
  attr_reader :errors

  def initialize(opt)
    @opt = opt
    @errors = []
  end

  def valid?(value)
    @errors = []

    unless value.is_a?(Date) || value.is_a?(Time) || (Date.parse(value) rescue false)
      @errors << I18n.t('errors.messages.contracts.date_format')
    end

    @errors.empty?
  end
end
