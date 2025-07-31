# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @posts = Post.all.limit(10).includes(:user, :likes).order('created_at desc')
  end

  def search
    @users = User.name_search(params[:q])
  end

  def show; end

  def update
    if current_user.valid_password?(params[:password])
      @user = current_user
      render 'users/_updateavatar'
    else
      redirect_to posts_path, alert: t('password_failed')
    end
  end

  def new
    render 'users/_currentpassword'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
