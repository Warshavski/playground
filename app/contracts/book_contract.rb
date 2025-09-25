class BookContract
  include Validations::ValidationDsl
  my_validates :title, presence: true, space: true, length: [2, 80]
  my_validates :isbn13, numeric: true, presence: true
  my_validates :isbn10, numeric: true, presence: true
  my_validates :published_in, date_format: true
  my_validates :author_ids, presence: true

  def initialize(params)
    @params = params
    @errors = []
  end

  def errors
    @errors
  end
end