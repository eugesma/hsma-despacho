class EntryNotePolicy < ApplicationPolicy
  def index
    true
  end

  def create?
    (record.author == user) && (user.has_role? :dispatcher)
  end

  def new?
    (user.has_role? :dispatcher) || (user.has_role? :admin)
  end

  def update?
    (record.author == user) || (user.has_role? :admin)
  end

  def destroy?
    (record.author == user) || (user.has_role? :admin)
  end
end
