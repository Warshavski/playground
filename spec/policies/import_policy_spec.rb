# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportPolicy do
  subject(:policy) { described_class.new(:import, user:) }

  describe '#upload?' do
    context 'when user is admin' do
      let(:user) { create(:user, role: 'admin') }

      it 'allows upload' do
        expect(policy.upload?).to be(true)
      end
    end

    context 'when user is moderator' do
      let(:user) { create(:user, role: 'moderator') }

      it 'allows upload' do
        expect(policy.upload?).to be(true)
      end
    end

    context 'when user is regular user' do
      let(:user) { create(:user) }

      it 'denies upload' do
        expect(policy.upload?).to be(false)
      end
    end
  end

  describe '#create?' do
    context 'when user is admin' do
      let(:user) { create(:user, role: 'admin') }

      it 'allows create' do
        expect(policy.create?).to be(true)
      end
    end

    context 'when user is moderator' do
      let(:user) { create(:user, role: 'moderator') }

      it 'allows create' do
        expect(policy.create?).to be(true)
      end
    end

    context 'when user is regular user' do
      let(:user) { create(:user) }

      it 'denies create' do
        expect(policy.create?).to be(false)
      end
    end
  end
end
