class BookContract < ApplicationContract
  params do
    required(:title).filled(:string, min_size?: 2, max_size?: 80)
    required(:isbn13).filled(:integer)
    required(:isbn10).filled(:integer)
    required(:author_ids).filled(:array)
    required(:published_in).filled(:date)
    required(:publisher_id).filled(:integer)
  end

  rule(:title) do
    key.failure(:space) if value != value.strip
  end
end
