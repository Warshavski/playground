class BookContract
  def initialize(params)
    @params = params
    @errors = []
  end

  def valid?
    @errors = []

    validation_rules.each do |field, rule|
      value = @params[field]

      case field
      when :title
        title_validation(value, rule)
      when :isbn10
        isbn10_validation(value, rule)
      when :isbn13
        isbn13_validation(value, rule)
      when :author_ids
        author_ids_validation(value, rule)
      when :published_in
        published_in_validation(value, rule)
      end
    end

  @errors.empty?
end

  def errors
    @errors
  end

  private

  def title_validation(value, rule)
    if value.blank?
      @errors << I18n.t(rule[:blank])
    elsif value.length < 1
      @errors << I18n.t(rule[:too_short])
    elsif value.length > 80
      @errors << I18n.t(rule[:too_long])
    end
  end

  def isbn10_validation(value, rule)
    if value.present? && value !~ /\A\d+\z/
      @errors << I18n.t(rule[:not_numeric])
    end
  end

  def isbn13_validation(value, rule)
    if value.present? && value !~ /\A\d+\z/
      @errors << I18n.t(rule[:not_numeric])
    end
  end

  def author_ids_validation(value, rule)
    if value.blank?
      @errors << I18n.t(rule[:blank])
    end
  end

  def published_in_validation(value, rule)
    if value.blank?
      @errors << I18n.t(rule[:blank])
    end
  end

  def validation_rules
    {
      title: {
        blank:  'errors.messages.contracts.book.title.empty_title',
        too_short: 'errors.messages.contracts.book.title.short_title',
        too_long:  'errors.messages.contracts.book.title.long_title'
      },
      author_ids: {
        blank: 'errors.messages.contracts.book.author_ids.blank'
      },
      published_in: {
        blank: 'errors.messages.contracts.book.published_in.blank'
      },
      isbn10: {
        not_numeric: 'errors.messages.contracts.book.isbn.isbn10_not_numeric'
      },
      isbn13: {
        not_numeric: 'errors.messages.contracts.book.isbn.isbn13_not_numeric'
      }
    }
  end
end