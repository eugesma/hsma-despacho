class SectorPolicy < CommonPolicy
  def create?
    user.has_role? :admin || (user.has_role? :dispatcher)
  end

  def destroy?
    user.has_role? :admin
  end

  def delete?
    user.has_role? :admin
  end

  def update?
    user.has_role? :admin
  end
end
