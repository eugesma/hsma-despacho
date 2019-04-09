class OutNotePolicy < CommonPolicy
  def create?
    if user.has_role? :admin
      return true
    else
      super
    end
  end

  def destroy?
    if user.has_role? :admin
      return true
    else
      super
    end
  end

  def delete?
    if user.has_role? :admin
      return true
    else
      super
    end
  end

  def new_pass?
    if user.has_role? :admin
      return true
    else
      super
    end
  end
end
