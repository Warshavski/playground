# frozen_string_literal: true

class BookPolicy < ApplicationPolicy # rubocop:disable Style/Documentation
  def update?
    owner? || user.moderator? || user.admin?
  end

  def destroy?
    owner? || user.moderator? || user.admin?
  end

  private

  def owner?
    record.user_id == user.id
  end
end
