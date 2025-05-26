require 'rails_helper'

RSpec.describe "GenresController", type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET /genres" do
    subject { get genres_path, headers: { "Accept" => "application/json" } }

    context 'when DB is null' do
      it "returns empty array" do
        subject
        expect(json_response['genres']).to eq([])
      end
    end

    context 'when DB is not null' do
      let!(:genres) { create_list(:genre, 3) }

      it "returns a successful response" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "returns all genres with their details as JSON" do
        subject
        genres_array = json_response['genres']
        expect(genres_array.size).to eq(3)

        genres_array.each_with_index do |genre_hash, index|
          genre = genres[index]
          expect(genre_hash).to eq(
            {
              'id' => genre.id,
              'name' => genre.name,
              'description' => genre.description,
              'books' => []
            }
          )
        end
      end
    end
  end

  describe "GET /genres/:id" do
    let(:genre) { create(:genre, :with_books) }
    
    subject { get genre_path(genre), headers: { "Accept" => "application/json" } }

    it "returns a successful response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct genre as JSON" do
      subject
      expect(json_response['genre']['id']).to eq(genre.id)
      expect(json_response['genre']['name']).to eq(genre.name)
      expect(json_response['genre']['description']).to eq(genre.description)
    end
  end
end
