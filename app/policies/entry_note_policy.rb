class EntryNotePolicy < CommonPolicy
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
    return  ( user.has_role? :admin )  || ( user.has_role? :admin )
  end
end
