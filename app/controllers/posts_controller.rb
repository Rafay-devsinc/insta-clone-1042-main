# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit destroy update]

  def index
    @posts = current_user.posts
  end

  def edit
    authorize @post
  end

  def create
    @new_post = current_user.posts.new(new_post_params)
    authorize @new_post
    return unless @new_post.save

    redirect_to posts_path, notice: t('post_success')
  end

  def new
    @post = Post.new
  end

  def update
    authorize @post
    @post.caption = update_post_params[:caption]
    return unless @post.save

    redirect_to posts_path, notice: t('caption_success')
  end

  def destroy
    authorize @post
    redirect_to posts_path, notice: t('post_del_success') if @post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def new_post_params
    params.require(:post).permit(:caption, :user_id, images: [])
  end

  def update_post_params
    params.require(:post).permit(:caption)
  end
end
