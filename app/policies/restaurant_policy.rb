class RestaurantPolicy < ApplicationPolicy
  def create?
    user.has_role?(:admin, record)
  end

  def update?
    user.has_role?(:admin, record)
  end

  def destroy?
    user.has_role?(:admin, record)
  end

  def bulk_add?
    user.has_role?(:admin, record)
  end

  def add_user?
    user.has_role?(:admin, record)
  end

  def remove_user?
    user.has_role?(:admin, record)
  end

  def update_user?
    user.has_role?(:admin, record)
  end
end
