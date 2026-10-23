# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookPolicy do
  subject(:policy) { described_class.new(book, user:) }

  let(:user) { create(:user) }
  let(:book) { create(:book, user: owner) }

  describe '#update?' do
    context 'when user owns book' do
      let(:owner) { user }

      it 'allows update' do
        expect(policy.update?).to be(true)
      end
    end

    context 'when user does not own book' do
      let(:owner) { create(:user) }

      it 'denies update' do
        expect(policy.update?).to be(false)
      end
    end
  end

  describe '#destroy?' do
    context 'when user owns book' do
      let(:owner) { user }

      it 'allows destroy' do
        expect(policy.destroy?).to be(true)
      end
    end

    context 'when user does not own book' do
      let(:owner) { create(:user) }

      it 'denies destroy' do
        expect(policy.destroy?).to be(false)
      end
    end
  end
end
