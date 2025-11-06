require 'rails_helper'

RSpec.describe BookContract do
  subject(:contract) { described_class.new(params) }

  context 'when all params valid' do
    let(:params) do
      {
        title: 'valid book',
        isbn10: '1234567899',
        isbn13: '1234567899999',
        published_in: Date.today,
        author_ids: [1, 2]
      }
    end

    it 'valid is true' do
      expect(contract.valid?).to be true
    end
  end

  context 'when title is empty' do
    let(:params) do
      {
        title: '',
        isbn10: '1234567899',
        isbn13: '1234567899999',
        published_in: Date.today,
        author_ids: [1, 2]
      }
    end

    it 'valid is false, error for title' do
      expect(contract.valid?).to be false
      expect(contract.errors).to include({"title"=>["cant be blank"]})
    end
  end

  context 'when isbn10 is not numeric' do
    let(:params) do
      {
        title: 'valid book title',
        isbn10: 'gggggggggg',
        isbn13: '1234567899999',
        published_in: Date.today,
        author_ids: [1, 2]
      }
    end

    it 'valid is false, error for isbn10' do
      expect(contract.valid?).to be false
      expect(contract.errors).to include({"isbn10"=>["must be digits"]})
    end
  end

  context 'when published_in is not date' do
    let(:params) do
      {
        title: 'Valid',
        isbn10: '1234567899',
        isbn13: '1234567899999',
        published_in: 'stringgg',
        author_ids: [1, 2]
      }
    end

    it 'valid is false, date format error' do
      expect(contract.valid?).to be false
      expect(contract.errors).to include({"published_in"=>["must be YYYY-MM-DD, like 2025-09-22"]})
    end
  end

  context 'when author_ids is empty' do
    let(:params) do
      {
        title: 'Valid',
        isbn10: '1234567899',
        isbn13: '1234567899999',
        published_in: Date.today,
        author_ids: []
      }
    end

    it 'valid is false, error for author_ids' do
      expect(contract.valid?).to be false
      expect(contract.errors).to include({"author_ids"=>["cant be blank"]})
    end
  end
end