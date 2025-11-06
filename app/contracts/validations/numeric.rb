class Validations::Numeric
  attr_reader :errors

  def initialize(opt)
    @opt = opt
    @errors = []
  end

  def valid?(value)
    @errors = []

    if value.present? && value !~ /\A\d+\z/
      @errors << I18n.t('errors.messages.contracts.numeric')
    end

    @errors.empty?
  end
end