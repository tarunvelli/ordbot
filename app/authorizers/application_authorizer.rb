# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(adjective, user)
    # 'Whitelist' strategy for security: anything not explicitly allowed is
    # considered forbidden.
    user.has_role? :admin
  end

  def creatable_by?(user)
    # think of some fancy check
    true
  end

  def readable_by?(user)
    resource.users.include? user
  end

  def updatable_by?(user)
    resource.users.include? user && user.has_role?(:admin)
  end

  def deletable_by?(user)
    resource.users.include? user && user.has_role?(:admin)
  end
end
