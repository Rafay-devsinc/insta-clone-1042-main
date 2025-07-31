# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_user, only: %i[show follow destroy]

  def index
    redirect_to controller: :users, action: :index if user_signed_in?
  end

  def show; end

  def follow
    Relationship.find_or_create_by(follower_id: current_user.id, followee_id: @user.id)
    render action: 'show'
  end

  def destroy
    # unfollow
    current_user.followed_users.where(follower_id: current_user.id,
                                      followee_id: @user.id).destroy_all
    render action: 'show', locals: { user: @user }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
