require 'rails_helper'

RSpec.describe "GenresController", type: :request do
  describe "GET /genres" do
    let!(:genres) { create_list(:genre, 3) }
    subject { get genres_path, headers: { "Accept" => "application/json"} }

    it "returns a successful response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "returns all genres with their details as JSON" do
      subject
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)

      genres.each do |genre|
        expect(json_response).to include(
          a_hash_including(
            'id' => genre.id,
            'name' => genre.name,
            'description' => genre.description
          )
        )
      end
    end
  end

  describe "GET /genres/:id" do
    let(:genre) { create(:genre, :with_books) }
    subject { get genre_path(genre), headers: { "Accept" => "application/json"} }

    it "returns a successful response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct genre as JSON" do
      subject
      expect(json_response['id']).to eq(genre.id)
      expect(json_response['name']).to eq(genre.name)
      expect(json_response['description']).to eq(genre.description)
    end
  end
end
