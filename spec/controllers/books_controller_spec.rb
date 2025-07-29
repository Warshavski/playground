require 'rails_helper'

RSpec.describe "BooksController", type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET /books" do
    subject { get books_path, headers: { "Accept" => "application/json" } }

    context 'when DB is null' do
      it "returns empty array" do
        subject
        expect(json_response['books']).to eq([])
      end
    end

    context 'when DB is not null' do
      let!(:books) { create_list(:book, 3) }

      it "returns a successful response" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "returns all books with their details as JSON" do
        subject
        books_array = json_response['books']
        expect(books_array.size).to eq(3)

        books_array.each_with_index do |book_hash, index|
          book = books[index]
          expect(book_hash).to eq(
            {
              'id' => book.id,
              'title' => book.title,
              "weight"=>book.weight,
              "pages_count"=>book.pages_count,
              "description"=>book.description,
              "isbn13"=>book.isbn13,
              "isbn10"=>book.isbn10,
              "published_in"=>book.published_in.to_s,
              "publisher_name"=>book.publisher.name,
              "authors"=>[
                  {
                      "first_name"=>book.authors.first.first_name,
                      "last_name"=>book.authors.first.last_name
                  }
              ],
              "genres"=>[]
            }
          )
        end
      end
    end    
  end

  describe "GET /books/:id" do
    let!(:book) { create(:book) }
    
    subject { get book_path(book), headers: { "Accept" => "application/json" } }

    it "returns a successful response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct book as JSON" do
      subject
      expect(json_response['book']['id']).to eq(book.id)
      expect(json_response['book']['title']).to eq(book.title)
      expect(json_response['book']['pages_count']).to eq(book.pages_count)
      expect(json_response['book']['description']).to eq(book.description)
      expect(json_response['book']['isbn13']).to eq(book.isbn13)
      expect(json_response['book']['isbn10']).to eq(book.isbn10)
      expect(json_response['book']['published_in']).to eq(book.published_in.to_s)
      expect(json_response['book']['publisher_name']).to eq(book.publisher.name)
    end
  end

  describe "POST /books" do
    let!(:publisher) { create(:publisher) }
    let!(:authors) { create_list(:author, 2) }
    let!(:genres) { create_list(:genre, 1) }
    let!(:valid_params) do
      {
        book: {
          title: "Sumerki",
          description: "description",
          published_in: "2008-07-23",
          publisher_id: publisher.id,
          pages_count: 34,
          weight: 400,
          isbn10: "11",
          isbn13: "11",
          author_ids: authors.map(&:id),
          genre_ids: genres.map(&:id)
        }
      }
    end

    it "create new book" do
      post books_path, params: valid_params, headers: { "Accept" => "application/json" }

      expect(response).to have_http_status(:created)
      expect(Book.count).to eq(1)

      json = json_response['book'] || json_response
      expect(json['title']).to eq("Sumerki")
      expect(json['publisher_name']).to eq(publisher.name)
      expect(json['authors'].size).to eq(2)
      expect(json['genres'].size).to eq(1)
    end
  end

  describe "PATCH /book/:id" do
    let!(:book) { create(:book, title: "first_title") }

    let(:update_params) do
      {
        book: {
          title: "second_title"
        }
      }
    end

    subject do
      patch book_path(book),
            params: update_params,
            headers: { "Accept" => "application/json" }
    end

    it "updates book and returns success" do
      subject
      expect(response).to have_http_status(:ok)

      json = json_response['book'] || json_response
      expect(json['title']).to eq("second_title")
      expect(book.reload.title).to eq("second_title")
    end
  end

    describe "DELETE /books/:id" do
    let!(:book) { create(:book) }

    subject do
      delete book_path(book), headers: { "Accept" => "application/json" }
    end

    it "deletes book" do
      expect { subject }.to change(Book, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
