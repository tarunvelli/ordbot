class UserPolicy < ApplicationPolicy
  def super_dashboard?
    user.has_role?(:super_user)
  end
end
