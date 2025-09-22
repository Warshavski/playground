class BookContract
  def initialize(params)
    @params = params
    @errors = []
  end

  def valid?
    @errors = []

    validation_rules.each do |field, strategies|
      value = @params[field]
      Array(strategies).each do |strategy|
        unless strategy.valid?(value)
          @errors.concat(strategy.errors)
        end
      end
    end

    @errors.empty?
  end

  def errors
    @errors
  end

  private

  def validation_rules
    {
      title: [Validations::Presence.new, Validations::Space.new, Validations::Length.new(2, 80)],
      isbn10: [Validations::Presence.new, Validations::Numeric.new],
      isbn13: [Validations::Presence.new, Validations::Numeric.new],
      author_ids: [Validations::Presence.new],
      published_in: [Validations::Presence.new, Validations::Space.new, Validations::DateFormat.new],
    }
  end
end