class CommonPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    (record.author == user) && (user.has_role? :dispatcher)
  end

  def new?
    (user.has_role? :dispatcher) || (user.has_role? :admin)
  end

  def new_pass?
    (user.has_role? :dispatcher) || (user.has_role? :admin)
  end

  def edit_pass?
    (user.has_role? :dispatcher) || (user.has_role? :admin)
  end

  def update?
    (record.author == user) || (user.has_role? :admin)
  end

  def destroy?
    record.author == user
  end

  def delete?
    record.author == user
  end
end
