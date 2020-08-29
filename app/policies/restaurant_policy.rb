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

  def parse?
    user.has_role?(:admin, record)
  end
end