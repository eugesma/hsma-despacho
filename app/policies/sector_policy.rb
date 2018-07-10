class SectorPolicy < CommonPolicy
  def create?
    super unless user.has_role? :admin
    return true
  end

  def destroy?
    user.has_role? :admin
  end

  def delete?
    super unless user.has_role? :admin
    return true
  end

  def update?
    user.has_role? :admin
  end
end
