class RestaurantAuthorizer < ApplicationAuthorizer
  def creatable_by?(_user)
    # think of some fancy check
    true
  end

  def readable_by?(user)
    resource.users.include? user
  end

  def updatable_by?(user)
    resource.users.include?(user) && user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.users.include?(user) && user.has_role?(:admin)
  end
end
