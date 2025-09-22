class BookContract
  def initialize(params)
    @params = params
    @errors = []
  end

  def valid?
    @errors = []

    validation_rules.each do |field, strategy|
      value = @params[field]
      unless strategy.valid?(value)
        @errors.concat(strategy.errors)
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
      title: BookStrategies::TitleValidation.new,
      isbn10: BookStrategies::Isbn10Validation.new,
      isbn13: BookStrategies::Isbn13Validation.new,
      author_ids: BookStrategies::AuthorIdsValidation.new,
      published_in: BookStrategies::PublishedInValidation.new
    }
  end
end