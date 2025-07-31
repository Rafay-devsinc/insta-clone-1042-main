# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def initialize(user, post)
    @user = user
    @post = post
  end

  def edit?
    post.user_id == user.id
  end

  def update?
    post.user_id == user.id
  end

  def create?
    post.user_id.equal? user.id
  end

  def destroy?
    post.user_id == user.id
  end
end
