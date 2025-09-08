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
        if value.blank?
          @errors << I18n.t(rule[:blank])
        elsif value.length < 1
          @errors << I18n.t(rule[:too_short])
        elsif value.length > 80
          @errors << I18n.t(rule[:too_long])
        end

      when :isbn10
        if value.present? && value !~ /\A\d+\z/
          @errors << I18n.t(rule[:not_numeric])
        end

      when :isbn13
        if value.present? && value !~ /\A\d+\z/
          @errors << I18n.t(rule[:not_numeric])
        end

      else
        @errors << I18n.t(rule[:blank]) if value.blank?
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
      title: {
        blank:     'errors.messages.contracts.book.title.empty_title',
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