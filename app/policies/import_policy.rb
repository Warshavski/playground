class ImportPolicy < ApplicationPolicy
  def upload?
    user.admin? || user.moderator?
  end

  def create?
    user.admin? || user.moderator?
  end
end
