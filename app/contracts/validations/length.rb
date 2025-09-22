class Validations::Length
  def initialize(min, max)
    @min = min
    @max = max
    @errors = []
  end

  attr_reader :errors

  def valid?(value)
    @errors = []
    return true if value.blank?
    if @min && value.length < @min
      @errors << I18n.t("errors.messages.contracts.length_too_short", count: @min)
    end

    if @max && value.length > @max
      @errors << I18n.t("errors.messages.contracts.length_too_long", count: @max)
    end
    @errors.empty?
  end
end