class OutNotePolicy < CommonPolicy
  def create?
    super unless user.has_role? :admin
    return true
  end

  def destroy?
    super unless user.has_role? :admin
    return true
  end

  def delete?
    super unless user.has_role? :admin
    return true
  end
end
