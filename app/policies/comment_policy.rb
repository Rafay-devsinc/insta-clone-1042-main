# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def destroy?
    comment.user_id == user.id
  end

  def create?
    comment.comment_text.present?
  end
end
