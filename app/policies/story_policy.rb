# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  attr_reader :user, :story

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def initialize(user, story)
    @user = user
    @story = story
  end

  def destroy?
    story.user_id == user.id
  end
end
