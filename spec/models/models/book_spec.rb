# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { described_class.new(params) }

  let(:params) { {} }

  describe 'validations' do
    context 'when all required params exist' do
      let(:params) do
        {
          title: 'Война и мир',
          weight: 500,
          pages_count: 1225,
          published_in: Date.parse('01-01-1869'),
          publisher: Publisher.new(name: 'Издательство 1'),
          user: User.new(email: 'test@test.com', password: 'password123')
        }
      end

      it 'is valid' do
        expect(book).to be_valid
      end
    end

    context 'when required params are missing' do
      let(:params) do
        {
          weight: 500,
          pages_count: 1225
        }
      end

      it 'has errors for missing fields' do
        expect(book).not_to be_valid
        errors = book.errors.to_hash
        expect(errors.key?(:title)).to be_truthy
        expect(errors.key?(:published_in)).to be_truthy
        expect(errors.key?(:publisher)).to be_truthy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:publisher) }
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to have_and_belong_to_many(:genres) }
  end

  describe 'state'do
    context 'when book is created' do
      it 'has draft state' do
        expect(book.state).to eq('draft')
      end
    end

    context 'when book ready submit for review' do
      it 'changes state from draft to pending_review' do
        expect(book.submit_for_review).to be(true)
        expect(book.state).to eq('pending_review')
      end
    end

    context 'when book has draft state' do
      it 'cannot publishing' do
        expect(book.may_publish?).to be(false)
        expect { book.publish }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'when book is pending review' do
      it 'can be published' do
        expect(book.submit_for_review).to be(true)
        expect(book.state).to eq('pending_review')
        expect(book.publish).to be(true)
      end
    end
  end
end
