class BookContract
  def initialize(params)
    @params = params
  end

  def valid?
    @params[:title].present? && @params[:author_ids].present? && @params[:published_in].present?
  end

  def errors
    result = []
    result << "title is required" unless @params[:title].present?
    result << "author is required" unless @params[:author_ids].present?
    result << "published_in is required" unless @params[:published_in].present?
    result
  end
end
